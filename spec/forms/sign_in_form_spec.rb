require "rails_helper"

RSpec.describe SignInForm do
  subject { described_class }

  context "invalid" do
    before do
      @form = subject.new(username: "username", password: "password")
    end

    it "if credentials does not match" do
      @form.validate

      expected_result = { error: :invalid_credentials }
      result = @form.errors.details[:username]

      expect(result).to include(expected_result)
    end
  end

  context "valid" do
    let(:user) { create(:user) }

    before do
      @user = instance_double(User)
      allow(@user).to receive(:authenticate).with(anything).and_return(true)

      @form = subject.new(username: double, password: double)
      allow(@form).to receive(:user).and_return(@user)
    end

    it "is valid" do
      expect(@form).to be_valid
    end
  end
end