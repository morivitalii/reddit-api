require "rails_helper"

RSpec.describe Communities::IgnorePostReports do
  describe ".call" do
    it "makes post ignore reports" do
      post = create(:not_ignore_reports_post)
      service = described_class.new(post)

      service.call

      expect(service.post.ignore_reports).to be_truthy
    end
  end
end
