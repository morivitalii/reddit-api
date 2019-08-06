require "rails_helper"

RSpec.describe ForgotPasswordForm do
  include ActionMailer::TestHelper

  subject { described_class }

  let(:user) { create(:user) }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new
      end

      it "adds error on email field if email format is wrong" do
        @form.email = "wrong email format"
        @form.save

        expected_result = { error: :invalid }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end

      it "returns true if user with given email does not exists" do
        @form.email = "wrong@email.com"

        result = @form.save

        expect(result).to be_truthy
      end

      it "returns true if email was sent today" do
        allow(@form).to receive(:email_was_sent_today?).and_return(true)
        @form.email = user.email

        result = @form.save

        expect(result).to be_truthy
      end
    end

    context "valid" do
      before do
        @form = subject.new(email: user.email)
        allow(@form).to receive(:email_was_sent_today?).and_return(false)
      end

      it "updates user forgot_password_email_sent_at field" do
        expect { @form.save }.to change { user.reload.forgot_password_email_sent_at }
      end

      it "sends email" do
        assert_emails(1) do
          @form.save
        end
      end
    end
  end
end