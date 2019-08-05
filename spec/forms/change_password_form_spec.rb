require "rails_helper"

RSpec.describe ChangePasswordForm do
  let(:user) { create(:user) }

  describe ".save" do
    context "invalid" do
      subject { described_class.new(token: "invalid_token") }

      it "add error on password field when token is invalid" do
        subject.save

        expect(subject.errors.details[:password]).to include(error: :invalid_reset_password_link)
      end
    end

    context "valid" do
      subject do
        described_class.new(
          token: user.forgot_password_token,
          password: "new_password"
        )
      end

      it "update user password" do
        expect { subject.save }.to change { user.reload.password_digest }
      end

      it "regenerate token" do
        expect { subject.save }.to change { user.reload.forgot_password_token }
      end
    end
  end
end