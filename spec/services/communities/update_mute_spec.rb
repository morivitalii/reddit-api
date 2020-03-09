require "rails_helper"

RSpec.describe Communities::UpdateMute do
  describe ".call" do
    it "updates mute" do
      mute = create(:mute)
      service = described_class.new(
        mute: mute,
        reason: "Reason",
        days: 1,
        permanent: false
      )

      service.call

      expect(service.mute.reason).to eq("Reason")
      expect(service.mute.days).to eq(1)
      expect(service.mute.permanent).to eq(false)
    end
  end
end
