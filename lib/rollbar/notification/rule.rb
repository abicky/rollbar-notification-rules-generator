# frozen_string_literal: true
require "rollbar/notification/condition/environment"
require "rollbar/notification/condition/framework"
require "rollbar/notification/condition/level"
require "rollbar/notification/condition/path"
require "rollbar/notification/condition/rate"
require "rollbar/notification/condition/title"

module Rollbar
  class Notification
    class Rule
      attr_reader :conditions

      # @param conditions [Array<Hash>]
      def initialize(conditions)
        @conditions = conditions.map do |condition|
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
      end

      def initialize_dup(original)
        @conditions = original.conditions.dup
        super
      end

      def remove_redundant_conditions!
        @conditions.delete_if do |condition|
          @conditions.any? { |other| condition.redundant_to?(other) }
        end
        self
      end

      # @param old_condition [Rollbar::Notification::Condition::Base]
      # @param new_condition [Rollbar::Notification::Condition::Base]
      def replace_condition!(old_condition, new_condition)
        @conditions[@conditions.index(old_condition)] = new_condition
        self
      end

      def lowest_target_level
        level_condition&.level || 0
      end

      def lowest_target_level_value
        Rollbar::Notification::Condition::Level::SUPPORTED_VALUES[lowest_target_level]
      end

      # @param highest_lowest_target_level [Integer]
      # @return [Array<Rollbar:Notification::Rule>]
      def split_rules(highest_lowest_target_level)
        return [dup] if level_condition&.operation == "eq"

        if highest_lowest_target_level > lowest_target_level
          new_level_conditions = Rollbar::Notification::Condition::Level.build_eq_conditions_from(lowest_target_level)
          new_level_conditions.map do |condition|
            dup.replace_condition!(level_condition, condition)
          end
        else
          [dup]
        end
      end

      # @param new_conditions [Array<Rollbar::Notification::Condition::Base>]
      def add_conditions!(new_conditions)
        new_conditions.each do |new_condition|
          @conditions << new_condition
        end
        self
      end

      def build_additional_conditions_set_for_downstream
        target_levels = level_condition&.target_level_values || Rollbar::Notification::Condition::Level::SUPPORTED_VALUES

        conditions_with_complement = @conditions.select { |c| c.respond_to?(:build_complement_condition) }
        return {} if conditions_with_complement.empty?

        if conditions_with_complement.size == 1
          additional_conditions = [[conditions_with_complement.first.build_complement_condition]]
        else
          # [cond1, cond2, cond3]
          # => [
          #     [cond1, cond2, not-cond3],
          #     [cond1, not-cond2, cond3],
          #     [cond1, not-cond2, not-cond3],
          #     [not-cond1, cond2, cond3],
          #     [not-cond1, cond2, not-cond3],
          #     [not-cond1, not-cond2, cond3],
          #     [not-cond1, not-cond2, not-cond3],
          #   ]
          additional_conditions = conditions_with_complement.map do |condition|
            [condition, condition.build_complement_condition]
          end.reduce(&:product).map(&:flatten) - [conditions_with_complement]
        end
        target_levels.zip([additional_conditions].cycle).to_h
      end

      private

      def level_condition
        @conditions.find { |c| c.type == "level" }
      end
    end
  end
end
