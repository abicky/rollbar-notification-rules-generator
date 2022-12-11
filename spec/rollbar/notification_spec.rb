require "spec_helper"

RSpec.describe Rollbar::Notification do
  describe "generate_tf_file" do
    subject(:actual_tf) do
      out = StringIO.new
      described_class.new(yaml).generate_tf_file(out)
      out.string
    end

    %w[
      slack_default
      slack_title_conditions
      slack_path_conditions
      slack_multiple_conditions
    ].each do |name|
      context name do
        let(:yaml) { yaml_file(name) }
        let(:expected_tf) { tf_file_content(name) }

        it { expect(actual_tf).to eq expected_tf }
      end
    end
  end
end
