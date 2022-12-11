# frozen_string_literal: true

RSpec.describe Rollbar::Notification::Rules::Generator do
  it "has a version number" do
    expect(Rollbar::Notification::Rules::Generator::VERSION).not_to be nil
  end
end
