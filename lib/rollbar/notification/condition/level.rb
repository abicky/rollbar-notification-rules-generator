# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Level
        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
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
