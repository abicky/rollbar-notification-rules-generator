# frozen_string_literal: true
require "rollbar/notification/condition/base"

module Rollbar
  class Notification
    module Condition
      # @!attribute [r] path
      #  @return [String]
      class Path < Base
        # @return [Array<String>]
        SUPPORTED_OPERATIONS = %w[eq neq within nwithin regex nregex exists nexists]
        # @return [Hash{String => String}]
        OPERATION_TO_TEXT = {
          "eq" => "==",
          "neq" => "!=",
          "within" => "contains substring",
          "nwithin" => "does not contain substring",
          "regex" => "contains substring matching regex",
          "nregex" => "does not contain substring matching regex",
          "exists" => "exists",
          "nexists" => "does not exist",
        }

        attr_reader :path

        # @param path [String]
        # @param operation [String]
        # @param value [String]
        def initialize(path, operation, value)
          super(operation, value)
          @type = "path"
          @path = path
        end

        # @param other [Object]
        # @return [Boolean]
        def ==(other)
          super && path == other.path
        end
        alias :eql? :==

        # @return [Integer]
        def hash
          [self.class, type, operation, value, path].hash
        end

        # @return [String]
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

        # @return [String]
        def to_s
          %Q{#{@type} #{@path} #{OPERATION_TO_TEXT[@operation]} "#{@value}"}
        end

        # @return [Path]
        def build_complement_condition
          new_operation = @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
          self.class.new(@path, new_operation, @value)
        end

        # @param other [Base, Rate]
        # @return [Boolean]
        def redundant_to?(other)
          super && @path == other.path
        end
      end
    end
  end
end
