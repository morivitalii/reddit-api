require "rails_helper"

RSpec.describe ApproveCommentService do
  subject { described_class }

  describe ".call" do
    it "approves comment" do
      service = build_approve_comment_service

      service.call

      comment = service.comment
      user = service.user
      expect(comment.approved_by).to eq(user)
      expect(comment.approved_by).to be_present
    end
  end

  def build_approve_comment_service
    comment = create(:comment)
    user = create(:user)

    described_class.new(comment, user)
  end
end