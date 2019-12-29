require "rails_helper"

RSpec.describe UpdateUser do
  describe ".call" do
    it "updates user" do
      user = create(:user, email: "email@example.com", password: "password")
      service = described_class.new(
        user: user,
        email: "new_email@exampel.com",
        password: "new_password"
      )

      service.call

      expect(service.user.email).to eq("new_email@exampel.com")
      expect(service.user.password).to eq("new_password")
    end
  end
end
