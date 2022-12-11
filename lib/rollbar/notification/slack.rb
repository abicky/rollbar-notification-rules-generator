# frozen_string_literal: true
require "rollbar/notification/slack/trigger"

module Rollbar
  class Notification
    class Slack
      # @param triggers [Hash{String => Array<Hash>}]
      def initialize(triggers)
        @triggers = triggers.map do |trigger, rules|
          Rollbar::Notification::Slack::Trigger.new(trigger, rules)
        end
      end

      # @param out [IO]
      def generate_tf_file(out)
        out.puts(@triggers.map(&:to_tf).join("\n"))
      end
    end
  end
end
