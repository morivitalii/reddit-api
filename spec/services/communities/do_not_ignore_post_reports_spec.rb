require "rails_helper"

RSpec.describe Communities::DoNotIgnorePostReports do
  describe ".call" do
    it "makes post do not ignore reports" do
      post = create(:ignore_reports_post)
      service = described_class.new(post: post)

      service.call

      expect(service.post.ignore_reports).to be_falsey
    end
  end
end
