# frozen_string_literal: true
require "yaml"

require "rollbar/notification/channel"

module Rollbar
  class Notification
    CHANNEL_TO_TEXT = {
      "slack" => "Slack",
      "pagerduty" => "PagerDuty",
    }

    # @param config_file [String]
    def initialize(config_file)
      @config = YAML.load_file(config_file)
      @channel = Rollbar::Notification::Channel.new(
        @config.fetch("channel"),
        @config.fetch("triggers"),
        @config.fetch("variables", {})
      )
    end

    # @return [String]
    def to_s
      "# #{CHANNEL_TO_TEXT.fetch(@config.fetch("channel"))}\n#{@channel.to_s}"
    end

    # @return [String]
    def to_tf
      @channel.to_tf(@config["terraform_provider"])
    end
  end
end
