require "rails_helper"

RSpec.describe Communities::Posts::MarkAsExplicitService do
  describe ".call" do
    it "marks post as explicit" do
      service = build_service

      service.call

      post = service.post
      expect(post.explicit).to be_truthy
    end
  end

  def build_service
    post = create(:not_explicit_post)

    described_class.new(post)
  end
end
