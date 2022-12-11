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

        # @param name [String]
        # @param rules [Array<Hash>]
        def initialize(name, rules)
          @name = name
          @rules = rules.map do |rule|
            Rollbar::Notification::Rule.new(rule.fetch("conditions"))
          end
        end

        def to_tf
          @rules.map.with_index do |rule, i|
            TEMPLATE.result_with_hash({
              resource_name: "slack_#{@name}_#{i}",
              trigger: @name,
              conditions: rule.conditions,
            })
          end.join("\n")
        end
      end
    end
  end
end
