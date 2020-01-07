require "rails_helper"

RSpec.describe Communities::ApprovePost do
  describe ".call" do
    it "approves post" do
      post = create(:post)
      user = create(:user)
      service = described_class.new(post, user)

      service.call

      expect(service.post.approved_by).to eq(user)
      expect(service.post.approved_at).to be_present
    end
  end
end
