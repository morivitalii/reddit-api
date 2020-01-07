require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateReport do
  describe ".call" do
    context "comment ignores reports" do
      it "does not create comment report" do
        comment = create(:ignore_reports_comment)
        user = create(:user)
        service = described_class.new(
          comment: comment,
          user: user,
          text: "Report"
        )

        service.call

        expect(service.comment.reports.count).to eq(0)
      end
    end

    context "comment does not ignore reports" do
      it "creates comment report" do
        comment = create(:not_ignore_reports_comment)
        user = create(:user)
        service = described_class.new(
          comment: comment,
          user: user,
          text: "Report"
        )

        service.call

        expect(service.comment.reports.count).to eq(1)
      end
    end
  end
end
