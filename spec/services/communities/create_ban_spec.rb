require "rails_helper"

RSpec.describe Communities::CreateBan do
  describe ".call" do
    it "creates ban" do
      community = create(:community)
      target = create(:user)
      created_by = create(:user)

      service = described_class.new(
        community: community,
        created_by: created_by,
        user_id: target.id,
        end_at: Time.current.tomorrow
      )

      service.call

      expect(Ban.count).to eq(1)
    end
  end
end
