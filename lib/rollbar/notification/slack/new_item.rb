# frozen_string_literal: true
require "rollbar/notification/slack/trigger"

module Rollbar
  class Notification
    class Slack
      class NewItem < Trigger
        def to_s
          "new_item"
        end
      end
    end
  end
end
