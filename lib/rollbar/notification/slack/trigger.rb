# frozen_string_literal: true
require "erb"

require "rollbar/notification/rule"

module Rollbar
  class Notification
    class Slack
      class Trigger
        TEMPLATE = ERB.new(<<~TF)
          resource "rollbar_notification" "<%= resource_name %>" {
            channel = "slack"

            rule {
              trigger = "<%= trigger %>"
          <%= conditions.map { |condition| condition.to_tf.gsub(/^/, "    ") }.join.chomp %>
            }
          }
        TF

        # @param name [String]
        # @param rules [Array<Hash>]
        def initialize(name, rules)
          @name = name
          @rules = rules.map do |rule|
            Rollbar::Notification::Rule.new(rule.fetch("conditions"))
          end
        end

        def to_tf
          new_rules = []
          complement_conditions = Hash.new([])
          highest_lowest_target_level = 0
          @rules.each do |rule|
            rule.split_rules(highest_lowest_target_level).each do |new_rule|
              new_rule.add_conditions!(complement_conditions[new_rule.lowest_target_level_value])
              new_rules << new_rule
            end

            lowest_target_level = rule.lowest_target_level
            if lowest_target_level > highest_lowest_target_level
              highest_lowest_target_level = lowest_target_level
            end
            complement_conditions.merge!(rule.build_complement_conditions) { |_, v1, v2| v1 + v2 }
          end

          new_rules.map.with_index do |rule, i|
            TEMPLATE.result_with_hash({
              resource_name: "slack_#{@name}_#{i}",
              trigger: @name,
              conditions: rule.conditions,
            })
          end.join("\n")
        end
      end
    end
  end
end
