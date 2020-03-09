require "rails_helper"

RSpec.describe Communities::DeleteMute do
  describe ".call" do
    it "deletes mute" do
      mute = create(:mute)
      service = described_class.new(mute)

      service.call

      expect(Mute.count).to eq(0)
    end
  end
end
