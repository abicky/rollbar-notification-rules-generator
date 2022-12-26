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
        # @return [Array<String>]
        OPERATIONS_MET_ONLY_IF_PATH_EXISTS = %w[eq within nwithin regex nregex exists]

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

        # @param other [Base, Rate]
        # @return [Boolean]
        def never_met_with?(other)
          return false if self.class != other.class || path != other.path
          return true if operation == other.inverse_operation && value == other.value
          return true if operation == "nexists" && OPERATIONS_MET_ONLY_IF_PATH_EXISTS.include?(other.operation)
          return true if other.operation == "nexists" && OPERATIONS_MET_ONLY_IF_PATH_EXISTS.include?(operation)
          false
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
          s = +%Q{#{@type} #{@path} #{OPERATION_TO_TEXT[@operation]}}
          s << %Q{ "#{@value}"} unless @operation.end_with?("exists")
          s
        end

        # @return [Array<Path>]
        def build_complement_conditions
          complement_cond = self.class.new(@path, inverse_operation, @value)
          case @operation
          when "within", "nwithin", "regex", "nregex"
            # Neither "nwithin" nor "nregex" matches the condition if the path doesn't exist,
            # so the complement condition of these operations equals (`complement_cond` OR nexists)
            [complement_cond, self.class.new(@path, "nexists", "")]
          else
            [complement_cond]
          end
        end

        # @param other [Base, Rate]
        # @return [Boolean]
        def redundant_to?(other)
          super && @path == other.path
        end

        # @return [String]
        def inverse_operation
          @operation.start_with?("n") ? @operation.delete_prefix("n") : "n#{@operation}"
        end
      end
    end
  end
end
