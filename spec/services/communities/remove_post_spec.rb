require "rails_helper"

RSpec.describe Communities::RemovePost do
  describe ".call" do
    it "removes post" do
      post = create(:post)
      user = create(:user)
      service = described_class.new(
        post: post,
        user: user,
        reason: "Reason"
      )

      service.call

      expect(service.post.removed_by).to eq(user)
      expect(service.post.removed_at).to be_present
      expect(service.post.removed_reason).to eq("Reason")
    end
  end
end
