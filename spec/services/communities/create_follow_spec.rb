require "rails_helper"

RSpec.describe Communities::CreateFollow do
  describe ".call" do
    context "when follow exists" do
      it "does not create new one" do
        user = create(:user)
        community = create(:community_with_user_follower, user: user)
        service = described_class.new(community, user)

        service.call

        expect(Follow.count).to eq(1)
      end
    end

    context "when follow does not exist" do
      it "creates new one" do
        user = create(:user)
        community = create(:community)
        service = described_class.new(community, user)

        service.call

        expect(Follow.count).to eq(1)
      end
    end
  end
end
