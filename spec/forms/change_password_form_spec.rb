require "rails_helper"

RSpec.describe ChangePasswordForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new(token: double, password: double)
      end

      it "if token is blank" do
        @form.token = ""
        @form.validate

        expected_result = { error: :blank }
        result = @form.errors.details[:token]

        expect(result).to include(expected_result)
      end

      it "if password is blank" do
        @form.password = ""
        @form.validate

        expected_result = { error: :blank }
        result = @form.errors.details[:password]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      before do
        @form = subject.new(token: double, password: double)
        @user = instance_double(User)

        allow(@form).to receive(:user).and_return(@user)
      end

      it { expect(@form).to be_valid }

      it "updates user password and forgot password token" do
        expect(@user).to receive(:update!).with(password: anything)
        expect(@user).to receive(:regenerate_forgot_password_token)

        @form.save
      end
    end
  end
end