require "rails_helper"

RSpec.describe SignUp do
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        service = described_class.new(
          username: "",
          password: "",
          email: ""
        )

        service.call

        expect(service.errors).to_not be_blank
      end
    end

    context "with invalid attributes" do
      it "is invalid" do
        service = described_class.new(
          username: "username",
          password: "password",
          email: "email@example.com"
        )

        service.call

        expect(service.errors).to be_blank
      end
    end
  end

  describe ".call" do
    it "creates user" do
      service = described_class.new(
        username: "username",
        password: "password",
        email: "email@example.com"
      )

      expect { service.call }.to change { User.count }.by(1)
    end
  end
end
