require "rails_helper"

RSpec.describe Communities::Posts::Comments::Reports::IgnoreService do
  describe ".call" do
    it "makes comment ignore reports" do
      service = build_service

      service.call

      comment = service.comment
      expect(comment.ignore_reports).to be_truthy
    end
  end

  def build_service
    comment = create(:not_ignore_reports_comment)

    described_class.new(comment)
  end
end
