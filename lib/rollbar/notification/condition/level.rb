# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Level < Base
        SUPPORTED_OPERATIONS = %w[eq gte]
        SUPPORTED_VALUES = %w[debug info warning error critical]

        # @param lowest_target_level [Integer]
        # @return [Array<Level>]
        def self.build_eq_conditions_from(lowest_target_level)
          SUPPORTED_VALUES[lowest_target_level..].map do |value|
            new("eq", value)
          end
        end

        attr_reader :level

        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
          super
          @type = "level"

          @level = SUPPORTED_VALUES.index(value)
          unless @level
            raise ArgumentError, "Unsupported value: #{value}"
          end
        end

        # @return [Array<String>]
        def target_level_values
          @operation == "eq" ? [@value] : SUPPORTED_VALUES[@level..]
        end
      end
    end
  end
end
