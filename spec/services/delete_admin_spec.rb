require "rails_helper"

RSpec.describe DeleteAdmin do
  describe ".call" do
    it "deletes admin" do
      admin = create(:admin)
      service = described_class.new(admin: admin)

      service.call

      expect(Admin.count).to eq(0)
    end
  end
end
