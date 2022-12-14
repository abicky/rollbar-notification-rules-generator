# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Title < Base
        SUPPORTED_OPERATIONS = %w[within nwithin regex nregex]
        OPERATION_TO_TEXT = {
          "within" => "contains substring",
          "nwithin" => "does not contain substring",
          "regex" => "contains substring matching regex",
          "nregex" => "does not contain substring matching regex",
        }

        def initialize(operation, value)
          super
          @type = "title"
        end

        # @return [String]
        def to_s
          %Q{#{@type} #{OPERATION_TO_TEXT[@operation]} "#{@value}"}
        end

        def build_complement_condition
          new_operation = @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
          self.class.new(new_operation, @value)
        end
      end
    end
  end
end
