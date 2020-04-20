require "rails_helper"

RSpec.describe Communities::MarkPostAsSpoiler do
  describe ".call" do
    it "marks post as spoiler" do
      post = create(:not_spoiler_post)
      service = described_class.new(post: post)

      service.call

      expect(service.post.spoiler).to be_truthy
    end
  end
end
