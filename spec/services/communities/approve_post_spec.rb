require "rails_helper"

RSpec.describe Communities::ApprovePost do
  describe ".call" do
    it "approves post" do
      post = create(:removed_post)
      user = create(:user)
      service = described_class.new(post, user)

      service.call

      expect(service.post.approved_by).to eq(user)
      expect(service.post.removed_by).to be_nil
      expect(service.post.removed_reason).to be_nil
      expect(service.post.approved_at).to be_present
      expect(service.post.removed_at).to be_nil
    end
  end
end
