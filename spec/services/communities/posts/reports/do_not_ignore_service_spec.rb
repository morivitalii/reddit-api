require "rails_helper"

RSpec.describe Communities::Posts::Reports::DoNotIgnoreService do
  describe ".call" do
    it "makes post do not ignore reports" do
      service = build_service

      service.call

      post = service.post
      expect(post.ignore_reports).to be_falsey
    end
  end

  def build_service
    post = create(:ignore_reports_post)

    described_class.new(post)
  end
end
