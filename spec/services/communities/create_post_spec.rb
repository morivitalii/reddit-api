require "rails_helper"

RSpec.describe Communities::CreatePost do
  describe ".call"do
    it "creates post" do
      user = create(:user)
      community = create(:community)

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

    context "by user with permissions to approve posts" do
      it "approves post" do
        user = create(:user)
        community = create(:community_with_user_moderator, user: user)

        service = described_class.new(
          community: community,
          created_by: user,
          title: "Title",
          text: "Text",
          explicit: false,
          spoiler: false
        )

        service.call

        expect(service.post.approved_by).to eq(user)
        expect(service.post.approved_at).to be_present
      end
    end

    context "by user with no permissions to approve posts" do
      it "does not approve post" do
        user = create(:user)
        community = create(:community)

        service = described_class.new(
          community: community,
          created_by: user,
          title: "Title",
          text: "Text",
          explicit: false,
          spoiler: false
        )

        service.call

        expect(service.post.approved_by).to be_nil
        expect(service.post.approved_at).to be_nil
      end
    end
  end
end
