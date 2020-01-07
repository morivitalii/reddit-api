require "rails_helper"

RSpec.describe Communities::RemovePost do
  describe ".call" do
    it "removes post" do
      post = create(:post_with_reports, :approved)
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
      expect(service.post.reports.count).to eq(0)
    end
  end
end
