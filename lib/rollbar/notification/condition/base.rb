# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      # @!attribute [r] type
      #  @return [String]
      # @!attribute [r] operation
      #  @return [String]
      # @!attribute [r] value
      #  @return [String]
      class Base
        attr_reader :type, :operation, :value

        # @param operation [String]
        # @param value [String]
        def initialize(operation, value)
          unless self.class::SUPPORTED_OPERATIONS.include?(operation)
            raise ArgumentError, "Unsupported operation: #{operation}"
          end

          @operation = operation
          @value = value
        end

        # @param other [Object]
        # @return [Boolean]
        def ==(other)
          self.class == other.class &&
            type == other.type &&
            operation == other.operation &&
            value == other.value
        end
        alias :eql? :==

        # @return [Integer]
        def hash
          [self.class, type, operation, value].hash
        end

        # @return [String]
        def to_tf
          <<~TF
            filters {
              type      = "#{@type}"
              operation = "#{@operation}"
              value     = "#{@value}"
            }
          TF
        end

        # @param other [Base, Rate]
        # @return [Boolean]
        def redundant_to?(other)
          self.class == other.class &&
            @operation == "neq" &&
            other.operation == "eq" &&
            @value != other.value
        end
      end
    end
  end
end
