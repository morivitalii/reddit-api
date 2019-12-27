require "rails_helper"

RSpec.describe SignIn do
  context "when user with given username does not exist" do
    it "has error :invalid_credentials on username attribute" do
      form = described_class.new(username: "invalid", password: "password")
      form.validate

      expect(form).to have_error(:invalid_credentials).on(:username)
    end
  end

  context "when user with given username exists" do
    context "and password does not match" do
      it "has error :invalid_credentials on username attribute" do
        create(:user, username: "username", password: "password")
        form = described_class.new(username: "username", password: "wrong_password")

        form.validate

        expect(form).to have_error(:invalid_credentials).on(:username)
      end
    end

    context "and credentials match" do
      it "is valid" do
        create(:user, username: "username", password: "password")
        form = described_class.new(username: "username", password: "password")

        expect(form).to be_valid
      end
    end
  end
end
