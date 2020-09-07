require "rails_helper"

RSpec.describe Communities::UpdateMute do
  describe ".call" do
    it "updates mute" do
      mute = create(:mute)
      updated_by = create(:user)
      end_at = Time.current.tomorrow

      service = described_class.new(
        mute: mute,
        updated_by: updated_by,
        end_at: end_at
      )

      service.call

      expect(service.mute.end_at).to eq(end_at)
    end
  end
end
