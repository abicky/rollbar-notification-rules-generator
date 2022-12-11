# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Framework < Base
        SUPPORTED_OPERATIONS = %w[eq]

        def initialize(operation, value)
          super
          @type = "framework"
        end
      end
    end
  end
end
