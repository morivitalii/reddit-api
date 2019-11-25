require "rails_helper"

RSpec.describe Communities::Posts::Reports::IgnoreService do
  describe ".call" do
    it "makes post ignore reports" do
      service = build_service

      service.call

      post = service.post
      expect(post.ignore_reports).to be_truthy
    end
  end

  def build_service
    post = create(:not_ignore_reports_post)

    described_class.new(post)
  end
end
