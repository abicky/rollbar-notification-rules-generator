# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Level
        SUPPORTED_OPERATIONS = %w[eq gte]
        SUPPORTED_VALUES = %w[debug info warning error critical]

        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
          unless SUPPORTED_OPERATIONS.include?(operation)
            raise ArgumentError, "Unsupported operation: #{operation}"
          end
          unless SUPPORTED_VALUES.include?(value)
            raise ArgumentError, "Unsupported value: #{value}"
          end
          @operation = operation
          @value = value
        end

        def to_tf
          <<~TF
            filters {
              type      = "level"
              operation = "#{@operation}"
              value     = "#{@value}"
            }
          TF
        end
      end
    end
  end
end