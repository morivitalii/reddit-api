require "rails_helper"

RSpec.describe Communities::Posts::DoNotIgnoreCommentReports do
  describe ".call" do
    it "makes comment do not ignore reports" do
      comment = create(:ignore_reports_comment)
      service = described_class.new(comment: comment)

      service.call

      expect(service.comment.ignore_reports).to be_falsey
    end
  end
end
