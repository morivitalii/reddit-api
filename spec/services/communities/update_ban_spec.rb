require "rails_helper"

RSpec.describe Communities::UpdateBan do
  describe ".call" do
    it "updates ban" do
      ban = create(:ban)
      service = described_class.new(
        ban: ban,
        reason: "Reason",
        days: 1,
        permanent: false
      )

      service.call

      expect(service.ban.reason).to eq("Reason")
      expect(service.ban.days).to eq(1)
      expect(service.ban.permanent).to eq(false)
    end
  end
end
