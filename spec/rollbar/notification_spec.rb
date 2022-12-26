require "spec_helper"

RSpec.describe Rollbar::Notification do
  inputs = %w[
    slack_default
    slack_title_conditions
    slack_path_conditions
    slack_multiple_conditions
    slack_eq_conditions
    slack_environment_conditions
    slack_conditions_with_multi_configs
    pagerduty_default
    variables
    terraform_provider
    terraform_namespace
    with_common_conditions
  ]

  describe "#to_tf" do
    subject(:actual_tf) do
      described_class.new(yaml).to_tf
    end

    inputs.each do |name|
      context name do
        let(:yaml) { yaml_file(name) }
        let(:expected_tf) { tf_file_content(name) }

        it { expect(actual_tf).to eq expected_tf }
      end
    end
  end

  describe "#to_s" do
    subject(:actual_text) do
      described_class.new(yaml).to_s
    end

    inputs.each do |name|
      context name do
        let(:yaml) { yaml_file(name) }
        let(:expected_text) { text_file_content(name) }

        it { expect(actual_text).to eq expected_text }
      end
    end
  end
end
