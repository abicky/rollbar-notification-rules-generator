# frozen_string_literal: true
require "yaml"

require "rollbar/notification/slack"

module Rollbar
  class Notification
    # @param config_file [String]
    def initialize(config_file)
      @config = YAML.load_file(config_file)
    end

    # @param out [IO]
    def generate_tf_file(out)
      case @config["channel"]
      when "slack"
        channel = Rollbar::Notification::Slack.new(@config["triggers"])
      else
        raise "Unsupported channel: #{@config["channel"]}"
      end
      channel.generate_tf_file(out)
    end
  end
end
