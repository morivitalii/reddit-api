require "rails_helper"

RSpec.describe Communities::RemovePost do
  describe ".call" do
    it "removes post" do
      post = create(:approved_post)
      user = create(:user)
      service = described_class.new(
        post: post,
        user: user,
        reason: "Reason"
      )

      service.call

      expect(service.post.removed_by).to eq(user)
      expect(service.post.approved_by).to be_nil
      expect(service.post.removed_at).to be_present
      expect(service.post.removed_reason).to eq("Reason")
      expect(service.post.approved_at).to be_nil
    end
  end
end
