require "rails_helper"

RSpec.describe Communities::Posts::Comments::CreateReportForm do
  describe ".save" do
    context "comment ignores reports" do
      it "does not create comment report" do
        form = build_form_with_ignore_reports_comment

        result = form.save

        expect(result).to be_truthy
        expect(form.comment.reports.count).to eq(0)
      end
    end

    context "comment does not ignore reports" do
      it "creates comment report" do
        form = build_form_with_not_ignore_reports_comment

        result = form.save

        expect(result).to be_truthy
        expect(form.comment.reports.count).to eq(1)
      end
    end
  end

  def build_form_with_ignore_reports_comment
    comment = create(:ignore_reports_comment)
    user = create(:user)

    described_class.new(
      comment: comment,
      user: user,
      text: "Report"
    )
  end

  def build_form_with_not_ignore_reports_comment
    comment = create(:not_ignore_reports_comment)
    user = create(:user)

    described_class.new(
      comment: comment,
      user: user,
      text: "Report"
    )
  end
end
