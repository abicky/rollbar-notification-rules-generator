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

      # @return [String]
      def to_s
        @triggers.map(&:to_s).join.chomp
      end

      # @param provider [String]
      def to_tf(provider)
        @triggers.map { |t| t.to_tf(provider) }.join("\n")
      end
    end
  end
end
