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
    end
  end
end
