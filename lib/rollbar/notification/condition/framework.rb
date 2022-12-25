# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Framework < Base
        # @return [Array<String>]
        SUPPORTED_OPERATIONS = %w[eq]

        def initialize(operation, value)
          super
          @type = "framework"
        end

        # @return [String]
        def to_s
          "#{@type} #{@value}"
        end
      end
    end
  end
end
