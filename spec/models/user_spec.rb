require "rails_helper"

RSpec.describe User do
  subject { described_class }

  describe ".to_param" do
    it "returns username" do
      username = "username"
      model = subject.new(username: username)
      expected_result = username
      result = model.to_param

      expect(result).to eq(expected_result)
    end
  end
end