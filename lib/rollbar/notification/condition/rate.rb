# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Rate
        attr_reader :type

        # @param count [Integer]
        # @param period [Integer]
        def initialize(count, period)
          @type = "rate"
          @count = count
          @period = period
        end

        def to_tf
          <<~TF
            filters {
              type   = "#{@type}"
              count  = #{@count}
              period = #{@period}
            }
          TF
        end

        # @param other [Base]
        # @return [Boolean]
        def redundant_to?(other)
          false
        end
      end
    end
  end
end
