require "rails_helper"

RSpec.describe Communities::IgnorePostReports do
  describe ".call" do
    it "makes post ignore reports" do
      post = create(:post_with_reports, :not_ignore_reports)
      service = described_class.new(post: post)

      service.call

      expect(service.post.ignore_reports).to be_truthy
      expect(service.post.reports.count).to eq(0)
    end
  end
end
