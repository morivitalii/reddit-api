require "rails_helper"

RSpec.describe Communities::Posts::IgnoreCommentReports do
  describe ".call" do
    it "makes comment ignore reports" do
      comment = create(:comment_with_reports, :not_ignore_reports)
      service = described_class.new(comment)

      service.call

      expect(service.comment.ignore_reports).to be_truthy
      expect(service.comment.reports.count).to eq(0)
    end
  end
end
