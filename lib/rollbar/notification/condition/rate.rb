# frozen_string_literal: true

module Rollbar
  class Notification
    module Condition
      class Rate
        # @param count [Integer]
        # @param period [Integer]
        def initialize(count, period)
          @count = count
          @period = period
        end

        def to_tf
          <<~TF
            filters {
              type   = "rate"
              count  = #{@count}
              period = #{@period}
            }
          TF
        end
      end
    end
  end
end
