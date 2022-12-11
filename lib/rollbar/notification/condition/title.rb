# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Title < Base
        SUPPORTED_OPERATIONS = %w[within nwithin regex nregex]

        def initialize(operation, value)
          super
          @type = "title"
        end

        def build_complement_condition
          new_operation = @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
          self.class.new(new_operation, @value)
        end
      end
    end
  end
end
