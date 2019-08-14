require "rails_helper"

RSpec.describe ForgotPasswordForm do
  include ActionMailer::TestHelper

  subject { described_class }

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe ".save" do
    before do
      @user = instance_double(User, email: "user@email.com", forgot_password_token: "token")
      @form = subject.new(email: @user.email)
    end

    it { expect(@form).to be_valid }

    it "does not send email if user with given email does not exist" do
      allow(@form).to receive(:user).and_return(nil)

      assert_no_emails do
        @form.save
      end
    end

    it "sends forgot password email if user with given email exists" do
      allow(@form).to receive(:user).and_return(@user)

      assert_emails(1) do
        @form.save
      end
    end
  end
end