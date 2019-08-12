require "rails_helper"

RSpec.describe ForgotPasswordForm do
  include ActionMailer::TestHelper

  subject { described_class }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new(email: double)
      end

      it "if email is blank" do
        @form.email = ""
        @form.validate

        expected_result = { error: :blank }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
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
end