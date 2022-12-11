# frozen_string_literal: true
require "rollbar/notification/slack/new_item"

module Rollbar
  class Notification
    class Slack
      # @param triggers [Hash{String => Array<Hash>}]
      def initialize(triggers)
        @triggers = triggers.map do |trigger, rules|
          case trigger
          when "new_item"
            Rollbar::Notification::Slack::NewItem.new(rules)
          else
            raise ArgumentError, "Unsupported trigger: #{trigger}"
          end
        end
      end

      # @param out [IO]
      def generate_tf_file(out)
        out.puts(@triggers.map(&:to_tf).join("\n"))
      end
    end
  end
end
