# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      class Path < Base
        SUPPORTED_OPERATIONS = %w[eq neq within nwithin regex nregex exists nexists]

        attr_reader :path

        # @param path [String]
        # @param operation [String]
        # @param value [String]
        def initialize(path, operation, value)
          super(operation, value)
          @type = "path"
          @path = path
        end

        def to_tf
          <<~TF
            filters {
              type      = "#{@type}"
              path      = "#{@path}"
              operation = "#{@operation}"
              value     = "#{@value}"
            }
          TF
        end

        # @return [Path]
        def build_complement_condition
          new_operation = @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
          self.class.new(@path, new_operation, @value)
        end

        # @return [Boolean]
        def redundant_to?(other)
          super && @path == other.path
        end
      end
    end
  end
end
