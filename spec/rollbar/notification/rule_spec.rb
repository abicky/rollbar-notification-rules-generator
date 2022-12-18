require "spec_helper"

RSpec.describe Rollbar::Notification::Rule do
  describe "#split_rules" do
    subject(:split_rules) { rule.split_rules(highest_lowest_target_level) }

    context "when the rule's operation is 'gte' and highest_lowest_target_level is less than or equal to the rule's value" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
            "type" => "level",
            "operation" => "gte",
            "value" => "error",
          }
          ],
        })
      end
      let(:highest_lowest_target_level) { Rollbar::Notification::Condition::Level::SUPPORTED_VALUES.index("error") }

      it "doesn't split the rule" do
        expect(split_rules).to eq([rule])
      end
    end

    context "when the rule's operation is 'gte' and highest_lowest_target_level is greater than the rule's value" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
              "type" => "level",
              "operation" => "gte",
              "value" => "error",
            }
          ],
        })
      end
      let(:highest_lowest_target_level) { Rollbar::Notification::Condition::Level::SUPPORTED_VALUES.index("critical") }

      it "split the rule into two rules with 'eq' operation" do
        expect(split_rules).to eq([
          described_class.new({
            "conditions" => [
              {
                "type" => "level",
                "operation" => "eq",
                "value" => "error",
              }
            ],
          }),
          described_class.new({
            "conditions" => [
              {
                "type" => "level",
                "operation" => "eq",
                "value" => "critical",
              }
            ],
          }),
        ])
      end
    end

    context "when the rule's operation is 'eq' and highest_lowest_target_level is greater than the rule's value" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
              "type" => "level",
              "operation" => "eq",
              "value" => "error",
            }
          ],
        })
      end
      let(:highest_lowest_target_level) { Rollbar::Notification::Condition::Level::SUPPORTED_VALUES.index("critical") }

      it "doesn't split the rule" do
        expect(split_rules).to eq([rule])
      end
    end
  end

  describe "#build_additional_conditions_set_for_subsequent_rules" do
    subject(:additional_conditions_set) { rule.build_additional_conditions_set_for_subsequent_rules }

    context "when the rule has only one condition with a complement condition" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
              "type" => "level",
              "operation" => "gte",
              "value" => "error",
            },
            {
              "type" => "title",
              "operation" => "within",
              "value" => "foo",
            },
          ],
        })
      end

      it do
        conditions_set = [
          [
            Rollbar::Notification::Condition::Title.new("nwithin", "foo"),
          ],
        ]

        expect(additional_conditions_set).to eq({
          "critical" => conditions_set,
          "error" => conditions_set,
        })
      end
    end

    context "when the rule has more than one conditions with a complement condition" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
              "type" => "level",
              "operation" => "gte",
              "value" => "error",
            },
            {
              "type" => "title",
              "operation" => "within",
              "value" => "foo",
            },
            {
              "type" => "title",
              "operation" => "within",
              "value" => "bar",
            },
            {
              "type" => "title",
              "operation" => "within",
              "value" => "baz",
            },
          ],
        })
      end

      it do
        conditions_set = [
          [
            Rollbar::Notification::Condition::Title.new("within", "foo"),
            Rollbar::Notification::Condition::Title.new("within", "bar"),
            Rollbar::Notification::Condition::Title.new("nwithin", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("within", "foo"),
            Rollbar::Notification::Condition::Title.new("nwithin", "bar"),
            Rollbar::Notification::Condition::Title.new("within", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("within", "foo"),
            Rollbar::Notification::Condition::Title.new("nwithin", "bar"),
            Rollbar::Notification::Condition::Title.new("nwithin", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("nwithin", "foo"),
            Rollbar::Notification::Condition::Title.new("within", "bar"),
            Rollbar::Notification::Condition::Title.new("within", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("nwithin", "foo"),
            Rollbar::Notification::Condition::Title.new("within", "bar"),
            Rollbar::Notification::Condition::Title.new("nwithin", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("nwithin", "foo"),
            Rollbar::Notification::Condition::Title.new("nwithin", "bar"),
            Rollbar::Notification::Condition::Title.new("within", "baz")
          ],
          [
            Rollbar::Notification::Condition::Title.new("nwithin", "foo"),
            Rollbar::Notification::Condition::Title.new("nwithin", "bar"),
            Rollbar::Notification::Condition::Title.new("nwithin", "baz")
          ],
        ]

        expect(additional_conditions_set).to eq({
          "critical" => conditions_set,
          "error" => conditions_set,
        })
      end
    end

    context "when the rule has only conditions without a complement condition" do
      let(:rule) do
        described_class.new({
          "conditions" => [
            {
              "type" => "level",
              "operation" => "gte",
              "value" => "error",
            },
          ],
        })
      end

      it { expect(additional_conditions_set).to eq({}) }
    end
  end
end
