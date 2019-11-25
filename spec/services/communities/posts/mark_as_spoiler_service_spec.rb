require "rails_helper"

RSpec.describe Communities::Posts::MarkAsSpoilerService do
  describe ".call" do
    it "marks post as spoiler" do
      service = build_service

      service.call

      post = service.post
      expect(post.spoiler).to be_truthy
    end
  end

  def build_service
    post = create(:not_spoiler_post)

    described_class.new(post)
  end
end
