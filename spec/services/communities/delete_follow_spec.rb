require "rails_helper"

RSpec.describe Communities::DeleteFollow do
  describe ".call" do
    it "deletes follow" do
      community = create(:community)
      user = create(:user)
      _follow = create(:follow, community: community, user: user)
      service = described_class.new(community, user)

      service.call

      expect(Follow.count).to eq(0)
    end
  end
end
