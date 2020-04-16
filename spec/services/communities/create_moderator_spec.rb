require "rails_helper"

RSpec.describe Communities::CreateModerator do
  describe ".call" do
    it "creates moderator" do
      community = create(:community)
      user = create(:user)
      service = described_class.new(
        community: community,
        user_id: user.id
      )

      service.call

      expect(Moderator.count).to eq(1)
    end
  end
end
