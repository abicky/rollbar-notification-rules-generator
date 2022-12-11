# frozen_string_literal: true
require "rollbar/notification/condition/level"

module Rollbar
  class Notification
    class Rule
      attr_reader :conditions

      # @param conditions [Array<Hash>]
      def initialize(conditions)
        @conditions = conditions.map do |condition|
          case condition.fetch("type")
          when "level"
            Rollbar::Notification::Condition::Level.new(condition.fetch("operation"), condition.fetch("value"))
          else
            raise ArgumentError, "Unsupported condition type: #{condition.fetch("type")}"
          end
        end
      end
    end
  end
end
