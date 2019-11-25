require "rails_helper"

RSpec.describe Communities::Posts::MarkAsNotSpoilerService do
  describe ".call" do
    it "marks post as not spoiler" do
      service = build_service

      service.call

      post = service.post
      expect(post.spoiler).to be_falsey
    end
  end

  def build_service
    post = create(:spoiler_post)

    described_class.new(post)
  end
end
