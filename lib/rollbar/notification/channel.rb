# frozen_string_literal: true
require "rollbar/notification/trigger"

module Rollbar
  class Notification
    class Channel
      CHANNEL_TO_TEXT = {
        "slack" => "Slack",
        "pagerduty" => "PagerDuty",
      }

      # @param channel [String]
      # @param triggers [Hash{String => Array<Hash>}]
      # @param variables [Hash{String => String}]
      def initialize(channel, triggers, variables)
        unless CHANNEL_TO_TEXT.include?(channel)
          raise ArgumentError, "Unsupported channel: #{channel}"
        end

        @channel = channel
        @triggers = triggers.map do |trigger, rules|
          Rollbar::Notification::Trigger.new(channel, trigger, rules, variables)
        end
      end

      # @return [String]
      def to_s
        "# #{CHANNEL_TO_TEXT.fetch(@channel)}\n#{@triggers.map(&:to_s).join.chomp}"
      end

      # @param provider [String]
      def to_tf(provider, namespace)
        @triggers.map { |t| t.to_tf(provider, namespace) }.join("\n")
      end
    end
  end
end
