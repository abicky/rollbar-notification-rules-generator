# frozen_string_literal: true
require "erb"

require "rollbar/notification/rule"

module Rollbar
  class Notification
    class Trigger
      TRIGGER_TO_TEXT = {
        "deploy" => "Deploy",
        "exp_repeat_item" => "10^nth Occurrence",
        "occurrence_rate" => "High Occurrence Rate",
        "new_item" => "New Item",
        "occurrence" => "Every Occurrence",
        "reactivated_item" => "Item Reactivated",
        "reopened_item" => "Item Reopened",
        "resolved_item" => "Item Resolved",
      }

      TEXT_TEMPLATE = ERB.new(<<~TEXT)
          conditions:
          <%= conditions.map { |condition| condition.to_s.gsub(/^/, "  ") }.join("\n").chomp %><% unless config.empty? %><% max_key_len = config.keys.map(&:size).max %>

          config:
          <%= config.compact.map { |key, value| '    %-*s = %s' % [max_key_len, key, value.inspect] }.join("\n") %><% end %>
      TEXT

      TF_TEMPLATE = ERB.new(<<~TF)
          resource "rollbar_notification" "<%= resource_name %>" {<% if provider %>
            provider = <%= provider %>
          <% end %>
            channel = "<%= channel %>"

            rule {
              trigger = "<%= trigger %>"
          <%= conditions.map { |condition| condition.to_tf.gsub(/^/, "    ") }.join.chomp %>
            }<% unless config.empty? %><% max_key_len = config.keys.map(&:size).max %>
            config {
          <%= config.compact.map { |key, value| '    %-*s = %s' % [max_key_len, key, value.inspect] }.join("\n") %>
            }<% end %>
          }
      TF

      # @param channel [String]
      # @param name [String]
      # @param rules [Array<Hash>]
      def initialize(channel, name, rules, variables)
        @channel = channel
        @name = name
        @rules = rules.map do |rule|
          Rollbar::Notification::Rule.new(rule)
        end
        @variables = variables
      end

      def to_s
        str = +"## #{TRIGGER_TO_TEXT.fetch(@name)}\n"
        i = -1
        build_mutually_exclusive_rules.each do |rule|
          rule.configs.map do |config|
            i += 1
            str << "### Rule #{i}\n"
            str << TEXT_TEMPLATE.result_with_hash({
              conditions: rule.conditions,
              config: config,
            }).gsub(/\${{\s*var\.(\w+)\s*}}/) { @variables.fetch($1) }
          end
          str << "\n"
        end

        str
      end

      def to_tf(provider, namespace)
        i = -1
        build_mutually_exclusive_rules.flat_map do |rule|
          rule.configs.map do |config|
            i += 1
            TF_TEMPLATE.result_with_hash({
              resource_name: "#{namespace}#{@channel}_#{@name}_#{i}",
              provider: provider,
              channel: @channel,
              trigger: @name,
              conditions: rule.conditions,
              config: config,
            }).gsub(/\${{\s*var\.(\w+)\s*}}/) { @variables.fetch($1) }
          end
        end.join("\n")
      end

      private

      # @return [Array<Rule>]
      def build_mutually_exclusive_rules
        new_rules = []
        level_value_to_additional_conditions_set = Hash.new([])
        highest_lowest_target_level = 0
        @rules.each do |rule|
          rule.split_rules(highest_lowest_target_level).each do |new_rule|
            additional_conditions_set = level_value_to_additional_conditions_set[new_rule.lowest_target_level_value]
            if additional_conditions_set.empty?
              new_rules << new_rule
            else
              additional_conditions_set.each do |additional_conditions|
                new_rule_with_additional_conds = new_rule.dup
                  .add_conditions!(additional_conditions)
                  .remove_redundant_conditions!
                unless new_rule_with_additional_conds.never_met?
                  new_rules << new_rule_with_additional_conds
                end
              end
            end
          end

          lowest_target_level = rule.lowest_target_level
          if lowest_target_level > highest_lowest_target_level
            highest_lowest_target_level = lowest_target_level
          end
          level_value_to_additional_conditions_set.merge!(rule.build_additional_conditions_set_for_subsequent_rules) do |_, v1, v2|
            additional_conditions_set = v1.product(v2).map(&:flatten)

            additional_conditions_set.reject! do |conditions|
              conditions.each.with_index.any? do |condition, i|
                conditions[i + 1 ..].any? { |other| other == condition.build_complement_condition }
              end
            end

            additional_conditions_set
          end
        end

        new_rules
      end
    end
  end
end
