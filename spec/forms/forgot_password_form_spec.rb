require "rails_helper"

RSpec.describe ForgotPasswordForm do
  it { expect(described_class.new).to_not be_persisted }

  describe "validations" do
    subject { build_forgot_password_form }

    it { is_expected.to validate_presence_of(:email) }
  end

  describe ".save" do
    context "when user with given email does not exist" do
      it "does not send email" do
        form = build_forgot_password_form
        form.save

        expect { form.save }.to_not have_enqueued_job
      end
    end

    context "when user with given email exists" do
      it "sends forgot password email" do
        user = create(:user)
        form = build_forgot_password_form
        form.email = user.email

        expect { form.save }.to have_enqueued_job
      end
    end
  end

  def build_forgot_password_form
    described_class.new(email: "email@email.com")
  end
end