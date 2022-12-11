# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Environment
        SUPPORTED_OPERATIONS = %w[eq neq]

        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
          unless SUPPORTED_OPERATIONS.include?(operation)
            raise ArgumentError, "Unsupported operation: #{operation}"
          end
          @operation = operation
          @value = value
        end

        def to_tf
          <<~TF
            filters {
              type      = "environment"
              operation = "#{@operation}"
              value     = "#{@value}"
            }
          TF
        end
      end
    end
  end
end
