require "rails_helper"

RSpec.describe Communities::MarkPostAsNotSpoiler do
  describe ".call" do
    it "marks post as not spoiler" do
      post = create(:spoiler_post)
      service = described_class.new(post: post)

      service.call

      expect(service.post.spoiler).to be_falsey
    end
  end
end
