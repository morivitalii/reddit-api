require "rails_helper"

RSpec.describe Communities::Posts::ApproveComment do
  describe ".call" do
    it "approves comment" do
      comment = create(:comment_with_reports, :removed)
      user = create(:user)
      service = described_class.new(comment, user)

      service.call

      expect(service.comment.approved_by).to eq(user)
      expect(service.comment.removed_by).to be_nil
      expect(service.comment.removed_reason).to be_nil
      expect(service.comment.approved_at).to be_present
      expect(service.comment.removed_at).to be_nil
      expect(service.comment.reports.count).to eq(0)
    end
  end
end
