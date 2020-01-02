require "rails_helper"

RSpec.describe Communities::CreatePost do
  describe ".call"do
    it "creates post" do
      community = create(:community)
      user = create(:user)
      service = described_class.new(
        community: community,
        created_by: user,
        title: "Title",
        text: "Text",
        explicit: false,
        spoiler: false
      )

      service.call

      expect(Post.count).to eq(1)
      expect(Topic.count).to eq(1)
      expect(Vote.count).to eq(1)
    end
  end
end
