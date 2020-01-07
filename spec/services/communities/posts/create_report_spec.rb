require "rails_helper"

RSpec.describe Communities::Posts::CreateReport do
  describe ".call" do
    context "post ignores reports" do
      it "does not create post report" do
        post = create(:ignore_reports_post)
        user = create(:user)
        service = described_class.new(
          post: post,
          user: user,
          text: "Report"
        )

        service.call

        expect(service.post.reports.count).to eq(0)
      end
    end

    context "post does not ignore reports" do
      it "creates post report" do
        post = create(:not_ignore_reports_post)
        user = create(:user)
        service = described_class.new(
          post: post,
          user: user,
          text: "Report"
        )

        service.call

        expect(service.post.reports.count).to eq(1)
      end
    end
  end
end
