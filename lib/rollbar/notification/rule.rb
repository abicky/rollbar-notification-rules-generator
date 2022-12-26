# frozen_string_literal: true
require "rollbar/notification/condition/environment"
require "rollbar/notification/condition/framework"
require "rollbar/notification/condition/level"
require "rollbar/notification/condition/path"
require "rollbar/notification/condition/rate"
require "rollbar/notification/condition/title"

module Rollbar
  class Notification
    # @!attribute [r] conditions
    #  @return [Array<Condition::Base, Condition::Rate>]
    # @!attribute [r] configs
    #  @return [Array<Hash{String => Object}>]
    class Rule
      # @param conditions [Array<Condition::Base, Condition::Rate>]
      # @return [Boolean]
      def self.never_met?(conditions)
        conditions.each.with_index.any? do |condition, i|
          # NOTE: `@conditions[i + 1 ..]` cannot be nil but `|| []` is required to suppress the warning "'any?' may produce 'NoMethodError'"
          (conditions[i + 1 ..] || []).any? do |other|
            next false unless condition.respond_to?(:build_complement_condition)
            other == condition.build_complement_condition
          end
        end
      end

      attr_reader :conditions, :configs

      # @param rule [Hash{String => Array<Object>}]
      def initialize(rule)
        @conditions = rule.fetch("conditions").map do |condition|
          case condition.fetch("type")
          when "environment"
            Rollbar::Notification::Condition::Environment.new(condition.fetch("operation"), condition.fetch("value"))
          when "framework"
            Rollbar::Notification::Condition::Framework.new(condition.fetch("operation"), condition.fetch("value"))
          when "level"
            Rollbar::Notification::Condition::Level.new(condition.fetch("operation"), condition.fetch("value"))
          when "path"
            Rollbar::Notification::Condition::Path.new(condition.fetch("path"), condition.fetch("operation"), condition.fetch("value"))
          when "rate"
            Rollbar::Notification::Condition::Rate.new(condition.fetch("count"), condition.fetch("period"))
          when "title"
            Rollbar::Notification::Condition::Title.new(condition.fetch("operation"), condition.fetch("value"))
          else
            raise ArgumentError, "Unsupported condition type: #{condition.fetch("type")}"
          end
        end
        @configs = rule.fetch("configs", [{}])
      end

      # @param original [Rule]
      # @return [void]
      def initialize_dup(original)
        @conditions = original.conditions.dup
        remove_instance_variable(:@level_condition)
        super
      end

      # @param other [Object]
      # @return [Boolean]
      def ==(other)
        self.class == other.class &&
          conditions == other.conditions &&
          configs == other.configs
      end

      # @return [Rule]
      def remove_redundant_conditions!
        @conditions.uniq!
        @conditions.delete_if do |condition|
          @conditions.any? { |other| condition.redundant_to?(other) }
        end
        self
      end

      def never_met?
        self.class.never_met?(@conditions)
      end

      # @param old_condition [Condition::Base]
      # @param new_condition [Condition::Base]
      # @return [Rule]
      def replace_condition!(old_condition, new_condition)
        @conditions[@conditions.index(old_condition)] = new_condition
        self
      end

      # @return [Integer]
      def lowest_target_level
        level_condition&.level || 0
      end

      # @return [String]
      def lowest_target_level_value
        Rollbar::Notification::Condition::Level::SUPPORTED_VALUES[lowest_target_level]
      end

      # Splits rules if necessary.
      # Assuming the following two rules:
      #   level = critical, title contains substring "bar"
      #   level >= error,   title contains substring "baz"
      # the second rule will be split into two rules with "eq" operation:
      #   level = critical, title contains substring "bar"
      #   level = critical, title contains substring "baz"
      #   level = error,    title contains substring "baz"
      # whereas assuming the following two rules:
      #   level = warning, title contains substring "bar"
      #   level >= error,   title contains substring "baz"
      # this method doesn't split the second rule because each rule
      # is already mutually exclusive.
      #
      # @param highest_lowest_target_level [Integer] the highest lowest_target_level
      #   among the preceding rules.
      # @return [Array<Rule>]
      def split_rules(highest_lowest_target_level)
        return [dup] if level_condition&.operation == "eq" || highest_lowest_target_level <= lowest_target_level

        new_level_conditions = Rollbar::Notification::Condition::Level.build_eq_conditions_from(lowest_target_level)
        if level_condition
          new_level_conditions.map do |condition|
            dup.replace_condition!(level_condition, condition)
          end
        else
          new_level_conditions.map do |condition|
            dup.add_conditions!(condition)
          end
        end
      end

      # @param new_conditions [Condition::Base, Array<Condition::Base>]
      # @return [Rule]
      def add_conditions!(new_conditions)
        @conditions.concat(Array(new_conditions))
        self
      end

      # @return [Hash{String => Array<Array<Condition::Base>>}]
      def build_additional_conditions_set_for_subsequent_rules
        target_levels = level_condition&.target_level_values || Rollbar::Notification::Condition::Level::SUPPORTED_VALUES

        conditions_with_complement = @conditions.select { |c| c.respond_to?(:build_complement_condition) }
        return {} if conditions_with_complement.empty?

        # Build set of conditions for the complement condition
        # e.g.
        # [cond1, cond2]
        # => [[not-cond1], [cond1, not-cond2]]
        #
        # [cond1, cond2, cond3]
        # => [[not-cond1], [cond1, not-cond2], [cond1, cond2, not-cond3]]
        #
        # [cond1, cond2, cond3, cond4]
        # => [
        #   [not-cond1],
        #   [cond1, not-cond2],
        #   [cond1, cond2, not-cond3],
        #   [cond1, cond2, cond3, not-cond4],
        # ]
        additional_conditions_set = conditions_with_complement.map.with_index do |cond, i|
          [*conditions_with_complement[... i], cond.build_complement_condition]
        end

        target_levels.zip([additional_conditions_set].cycle).to_h
      end

      private

      # @return [Condition::Level, nil]
      def level_condition
        return @level_condition if defined?(@level_condition)
        @level_condition = @conditions.find { |c| c.type == "level" }
      end
    end
  end
end
