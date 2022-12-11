# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Base
        attr_reader :type

        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
          unless self.class::SUPPORTED_OPERATIONS.include?(operation)
            raise ArgumentError, "Unsupported operation: #{operation}"
          end

          @operation = operation
          @value = value
        end

        def to_tf
          <<~TF
            filters {
              type      = "#{@type}"
              operation = "#{@operation}"
              value     = "#{@value}"
            }
          TF
        end
      end
    end
  end
end
