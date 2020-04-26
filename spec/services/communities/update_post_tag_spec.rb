require "rails_helper"

RSpec.describe Communities::UpdatePostTag do
  describe ".call" do
    it "updates post tag" do
      post = create(:without_tag_post)
      service = described_class.new(post: post, tag: "Tag")

      service.call

      expect(service.post.tag).to eq("Tag")
    end
  end
end
