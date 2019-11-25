require "rails_helper"

RSpec.describe Communities::Posts::CreateReportForm do
  describe ".save" do
    context "post ignores reports" do
      it "does not create post report" do
        form = build_form_with_ignore_reports_post

        result = form.save

        expect(result).to be_truthy
        expect(form.post.reports.count).to eq(0)
      end
    end

    context "post does not ignore reports" do
      it "creates post report" do
        form = build_form_with_not_ignore_reports_post

        result = form.save

        expect(result).to be_truthy
        expect(form.post.reports.count).to eq(1)
      end
    end
  end

  def build_form_with_ignore_reports_post
    post = create(:ignore_reports_post)
    user = create(:user)

    described_class.new(
      post: post,
      user: user,
      text: "Report"
    )
  end

  def build_form_with_not_ignore_reports_post
    post = create(:not_ignore_reports_post)
    user = create(:user)

    described_class.new(
      post: post,
      user: user,
      text: "Report"
    )
  end
end
