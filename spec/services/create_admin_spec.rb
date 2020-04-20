require "rails_helper"

RSpec.describe CreateAdmin do
  describe ".call" do
    it "creates admin" do
      user = create(:user)

      service = described_class.new(
        user_id: user.id
      )

      service.call

      expect(Admin.count).to eq(1)
    end
  end
end
