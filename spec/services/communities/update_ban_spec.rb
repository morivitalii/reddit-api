require "rails_helper"

RSpec.describe Communities::UpdateBan do
  describe ".call" do
    it "updates ban" do
      ban = create(:ban)
      updated_by = create(:user)
      end_at = Time.current.tomorrow
      service = described_class.new(
        ban: ban,
        updated_by: updated_by,
        end_at: end_at
      )

      service.call

      expect(service.ban.end_at).to eq(end_at)
    end
  end
end
