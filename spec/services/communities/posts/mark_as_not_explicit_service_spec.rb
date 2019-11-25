require "rails_helper"

RSpec.describe Communities::Posts::MarkAsNotExplicitService do
  describe ".call" do
    it "marks post as not explicit" do
      service = build_service

      service.call

      post = service.post
      expect(post.explicit).to be_falsey
    end
  end

  def build_service
    post = create(:explicit_post)

    described_class.new(post)
  end
end
