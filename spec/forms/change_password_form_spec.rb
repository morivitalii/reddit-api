require "rails_helper"

RSpec.describe ChangePasswordForm, type: :form do
  subject { described_class }

  describe "validations" do
    subject { build_change_password_form }

    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe ".save" do
    it "updates user password and forgot password token" do
      user = instance_double(User)
      form = build_change_password_form

      allow(form).to receive(:user).and_return(user)

      expect(user).to receive(:update!).with(password: anything)
      expect(user).to receive(:regenerate_forgot_password_token)

      form.save
    end
  end

  def build_change_password_form
    described_class.new(token: "token", password: "password")
  end
end