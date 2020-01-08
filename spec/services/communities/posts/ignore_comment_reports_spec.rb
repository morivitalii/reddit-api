require "rails_helper"

RSpec.describe Communities::Posts::IgnoreCommentReports do
  describe ".call" do
    it "makes comment ignore reports" do
      comment = create(:not_ignore_reports_comment)
      service = described_class.new(comment)

      service.call

      expect(service.comment.ignore_reports).to be_truthy
    end
  end
end
