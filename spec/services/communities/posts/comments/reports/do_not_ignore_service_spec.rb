require "rails_helper"

RSpec.describe Communities::Posts::Comments::Reports::DoNotIgnoreService do
  describe ".call" do
    it "makes comment do not ignore reports" do
      service = build_service

      service.call

      comment = service.comment
      expect(comment.ignore_reports).to be_falsey
    end
  end

  def build_service
    comment = create(:ignore_reports_comment)

    described_class.new(comment)
  end
end
