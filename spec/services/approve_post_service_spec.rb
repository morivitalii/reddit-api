require "rails_helper"

RSpec.describe ApprovePostService do
  subject { described_class }

  describe ".call" do
    it "approves post" do
      service = build_approve_post_service

      service.call

      post = service.post
      user = service.user
      expect(post.approved_by).to eq(user)
      expect(post.approved_by).to be_present
    end
  end

  def build_approve_post_service
    post = create(:post)
    user = create(:user)

    described_class.new(post, user)
  end
end
