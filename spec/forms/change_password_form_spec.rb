require "rails_helper"

RSpec.describe ChangePasswordForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      it "if token is blank" do
        form = build_change_password_form
        form.token = ""
        form.validate

        expect(form).to have_error(:blank).on(:token)
      end

      it "if password is blank" do
        form = build_change_password_form
        form.password = ""
        form.validate

        expect(form).to have_error(:blank).on(:password)
      end
    end

    context "valid" do
      it do
        form = build_change_password_form

        expect(form).to be_valid
      end

      it "updates user password and forgot password token" do
        user = instance_double(User)
        form = build_change_password_form

        allow(form).to receive(:user).and_return(user)

        expect(user).to receive(:update!).with(password: anything)
        expect(user).to receive(:regenerate_forgot_password_token)

        form.save
      end
    end
  end

  def build_change_password_form
    subject.new(token: double, password: double)

  end
end