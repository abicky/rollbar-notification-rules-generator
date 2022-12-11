# frozen_string_literal: true
require "rollbar/notification/condition/environment"
require "rollbar/notification/condition/framework"
require "rollbar/notification/condition/level"
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

      # @param old_condition [Rollbar::Notification::Condition::Base]
      # @param new_condition [Rollbar::Notification::Condition::Base]
      def replace_condition!(old_condition, new_condition)
        @conditions[@conditions.index(old_condition)] = new_condition
        self
      end

      def level_condition
        @conditions.find { |c| c.type == "level" }
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

      # @param conditions [Array<Rollbar::Notification::Condition::Base>]
      def add_conditions!(conditions)
        @conditions.concat(conditions)
        self
      end

      def build_complement_title_conditions
        target_levels = level_condition&.target_level_values || Rollbar::Notification::Condition::Level::SUPPORTED_VALUES

        complement_title_conditions = @conditions.select { |c| c.type == "title" }.map(&:build_complement_condition)
        target_levels.zip([complement_title_conditions].cycle).to_h
      end
    end
  end
end
