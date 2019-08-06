require "rails_helper"

RSpec.describe SignInForm do
  subject { described_class }

  context "invalid" do
    before do
      @form = subject.new
    end

    it "adds error on username field if given username format is wrong" do
      @form.username = "wrong username format"
      @form.validate

      expected_result = { error: :invalid_username_format }
      result = @form.errors.details[:username]

      expect(result).to include(expected_result)
    end

    it "adds error on username field if user with given username does not exist" do
      @form.username = "wrong username"
      @form.validate

      expected_result = { error: :invalid_username_format }
      result = @form.errors.details[:username]

      expect(result).to include(expected_result)
    end

    it "adds error on username field if user with given username exist but password is wrong" do
      user = create(:user)

      @form.username = user.username
      @form.password = "wrong password"
      @form.validate

      expected_result = { error: :invalid_credentials }
      result = @form.errors.details[:username]

      expect(result).to include(expected_result)
    end
  end

  context "valid" do
    let(:user) { create(:user) }

    before do
      @form = subject.new(
        username: user.username,
        password: user.password
      )
    end

    it "is valid" do
      @form.validate
      result = @form.errors

      expect(result).to be_blank
    end
  end
end