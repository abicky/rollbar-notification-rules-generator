# frozen_string_literal: true
require "erb"

require "rollbar/notification/rule"

module Rollbar
  class Notification
    class Slack
      class Trigger
        TEMPLATE = ERB.new(<<~TF)
          resource "rollbar_notification" "<%= resource_name %>" {
            channel = "slack"

            rule {
              trigger = "<%= trigger %>"
          <%= conditions.map { |condition| condition.to_tf.gsub(/^/, "    ") }.join.chomp %>
            }
          }
        TF

        # @param rules [Array<Hash>]
        def initialize(rules)
          @rules = rules.map do |rule|
            Rollbar::Notification::Rule.new(rule.fetch("conditions"))
          end
        end

        def to_tf
          @rules.map.with_index do |rule, i|
            TEMPLATE.result_with_hash({
              resource_name: "slack_#{to_s}_#{i}",
              trigger: to_s,
              conditions: rule.conditions,
            })
          end.join("\n")
        end
      end
    end
  end
end
