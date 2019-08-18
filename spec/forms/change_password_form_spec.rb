require "rails_helper"

RSpec.describe ChangePasswordForm, type: :form do
  subject { described_class }

  describe "validations" do
    subject { build_change_password_form }

    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:password) }
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
    form = described_class.new(token: "token", password: "password")
    allow(form).to receive(:user).and_return(user)

    form
  end
end