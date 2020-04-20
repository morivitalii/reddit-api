require "rails_helper"

RSpec.describe Communities::CreateFollow do
  describe ".call" do
    it "creates follow" do
      user = create(:user)
      community = create(:community)
      service = described_class.new(community: community, user: user)

      service.call

      expect(Follow.count).to eq(1)
    end
  end
end
