require "rails_helper"

RSpec.describe Communities::CreateMute do
  describe ".call" do
    it "creates mute" do
      community = create(:community)
      user = create(:user)

      service = described_class.new(
        community: community,
        user_id: user.id,
        permanent: true
      )

      service.call

      community_mutes_count = community.mutes.where(user: user).count
      expect(community_mutes_count).to eq(1)
    end
  end
end
