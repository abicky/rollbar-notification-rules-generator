# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Environment < Base
        SUPPORTED_OPERATIONS = %w[eq neq]

        def initialize(operation, value)
          super
          @type = "environment"
        end

        # @return [Environment]
        def build_complement_condition
          self.class.new(@operation == "eq" ? "neq" : "eq", @value)
        end
      end
    end
  end
end
