# frozen_string_literal: true
require "rollbar/notification/trigger"

module Rollbar
  class Notification
    class Channel
      SUPPORTED_CHANNELS = %w[slack pagerduty]

      # @param channel [String]
      # @param triggers [Hash{String => Array<Hash>}]
      # @param variables [Hash{String => String}]
      def initialize(channel, triggers, variables)
        unless SUPPORTED_CHANNELS.include?(channel)
          raise ArgumentError, "Unsupported channel: #{channel}"
        end

        @triggers = triggers.map do |trigger, rules|
          Rollbar::Notification::Trigger.new(channel, trigger, rules, variables)
        end
      end

      # @param out [IO]
      def generate_tf_file(out)
        out.puts(@triggers.map(&:to_tf).join("\n"))
      end
    end
  end
end
