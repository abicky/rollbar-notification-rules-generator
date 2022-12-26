# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Title < Base
        # @return [Array<String>]
        SUPPORTED_OPERATIONS = %w[within nwithin regex nregex]
        # @return [Hash{String => String}]
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

        # @param other [Base, Rate]
        # @return [Boolean]
        def never_met_with?(other)
          self.class == other.class &&
            self == other.build_complement_conditions.first
        end

        # @return [String]
        def to_s
          %Q{#{@type} #{OPERATION_TO_TEXT[@operation]} "#{@value}"}
        end

        # @return [Array<Title>]
        def build_complement_conditions
          new_operation = @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
          [self.class.new(new_operation, @value)]
        end
      end
    end
  end
end
