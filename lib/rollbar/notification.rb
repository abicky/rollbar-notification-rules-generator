# frozen_string_literal: true
require "yaml"

module Rollbar
  class Notification
    # @param config_file [String]
    def initialize(config_file)
      @config = YAML.load_file(config_file)
    end

    # @param out [IO]
    def generate_tf_file(out)
    end
  end
end
