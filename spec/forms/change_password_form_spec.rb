require "rails_helper"

RSpec.describe ChangePasswordForm do
  subject { described_class }

  describe ".save" do
    let(:user) { create(:user) }

    context "invalid" do
      it "adds error on password field when token is invalid" do
        form = subject.new(token: "invalid_token")
        form.save

        result = form.errors.details[:password]
        expected_result = { error: :invalid_reset_password_link }

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      before do
        @form = subject.new(
          token: user.forgot_password_token,
          password: "new_password"
        )
      end

      it "updates user password" do
        expect { @form.save }.to change { user.reload.password_digest }
      end

      it "regenerates token" do
        expect { @form.save }.to change { user.reload.forgot_password_token }
      end
    end
  end
end