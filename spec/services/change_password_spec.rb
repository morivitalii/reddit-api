require "rails_helper"

RSpec.describe ChangePassword do
  describe "validations" do
    context "when user with given token does not exist" do
      it "is invalid" do
        service = described_class.new(token: "token", password: "password")

        service.validate

        expect(service).to_not be_valid
        expect(service).to have_error(:invalid_forgot_password_token).on(:password)
      end
    end

    context "when user with given token exists" do
      it "is valid" do
        create(:user, forgot_password_token: "token")
        service = described_class.new(token: "token", password: "password")

        expect(service).to be_valid
      end
    end
  end

  describe ".call" do
    it "updates user password and forgot password token" do
      create(:user, forgot_password_token: "token")
      service = described_class.new(token: "token", password: "password")

      service.call

      expect(service.user.forgot_password_token).to_not eq("token")
      expect(service.user.password).to eq("password")
    end
  end
end
