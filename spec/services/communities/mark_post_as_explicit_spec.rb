require "rails_helper"

RSpec.describe Communities::MarkPostAsExplicit do
  describe ".call" do
    it "marks post as explicit" do
      post = create(:not_explicit_post)
      service = described_class.new(post)

      service.call

      expect(service.post.explicit).to be_truthy
    end
  end
end
