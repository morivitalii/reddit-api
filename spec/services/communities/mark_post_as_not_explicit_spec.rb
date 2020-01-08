require "rails_helper"

RSpec.describe Communities::MarkPostAsNotExplicit do
  describe ".call" do
    it "marks post as not explicit" do
      post = create(:explicit_post)
      service = described_class.new(post)

      service.call

      expect(service.post.explicit).to be_falsey
    end
  end
end
