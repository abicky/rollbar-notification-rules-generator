# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Environment < Base
        # @return [Array<String>]
        SUPPORTED_OPERATIONS = %w[eq neq]

        def initialize(operation, value)
          super
          @type = "environment"
        end

        # @param other [Base, Rate]
        # @return [Boolean]
        def never_met_with?(other)
          self.class == other.class &&
            self == other.build_complement_conditions.first
        end

        # @return [String]
        def to_s
          "#{@type} #{@operation == "eq" ? "==" : "!="} #{@value}"
        end

        # @return [Array<Environment>]
        def build_complement_conditions
          [self.class.new(@operation == "eq" ? "neq" : "eq", @value)]
        end
      end
    end
  end
end
