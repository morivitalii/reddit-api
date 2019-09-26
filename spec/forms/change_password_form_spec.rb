require "rails_helper"

RSpec.describe ChangePasswordForm, type: :form do
  it { expect(described_class.new).to be_persisted }

  describe "validations" do
    subject { build_change_password_form }

    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:password) }

    context "when user with given token does not exist" do
      it "is invalid" do
        form = build_change_password_form
        form.token = "invalid_token"

        expect(form).to_not be_valid
      end

      it "adds :invalid_forgot_password_token on :password attribute" do
        form = build_change_password_form
        form.token = "invalid_token"

        form.validate

        expect(form).to have_error(:invalid_forgot_password_token).on(:password)
      end
    end

    context "when user with given token exists" do
      it "is valid" do
        form = build_change_password_form

        expect(form).to be_valid
      end
    end
  end

  describe ".save" do
    it "updates user password" do
      form = build_change_password_form

      expect { form.save }.to change { form.user.password_digest }
    end

    it "updates user forgot password token" do
      form = build_change_password_form

      expect { form.save }.to change { form.user.forgot_password_token }
    end
  end

  def build_change_password_form
    user = create(:user)
    form = described_class.new(token: user.forgot_password_token, password: "password")
    allow(form).to receive(:user).and_return(user)

    form
  end
end
