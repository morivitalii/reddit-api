require "rails_helper"

RSpec.describe Communities::Posts::Comments::DeleteReport do
  describe ".call" do
    it "deletes comment report" do
      comment = create(:comment)
      report = create(:report, reportable: comment)
      service = described_class.new(report: report)

      service.call

      expect(comment.reports.count).to eq(0)
    end
  end
end
