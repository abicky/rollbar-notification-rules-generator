# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      # @!attribute [r] type
      #  @return [String]
      class Rate
        # @return [Hash{Integer => String}]
        PERIOD_TO_TEXT = {
          60 => "1 minute",
          300 => "5 minutes",
          1800 => "30 minutes",
          3600 => "1 hour",
          86400 => "1 day",
        }

        attr_reader :type

        # @param count [Integer]
        # @param period [Integer]
        def initialize(count, period)
          @type = "rate"
          @count = count
          @period = period
        end

        # @param other [Base, Rate]
        # @return [false]
        def never_met_with?(other)
          false
        end

        # @return [String]
        def to_s
          "At least #{@count} occurrences within #{PERIOD_TO_TEXT[@period]}"
        end

        # @return [String]
        def to_tf
          <<~TF
            filters {
              type   = "#{@type}"
              count  = #{@count}
              period = #{@period}
            }
          TF
        end

        # @param other [Base, Rate]
        # @return [Boolean]
        def redundant_to?(other)
          false
        end
      end
    end
  end
end
