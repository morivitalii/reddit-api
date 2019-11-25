require "rails_helper"

RSpec.describe Communities::Posts::Comments::ApproveService do
  describe ".call" do
    it "approves comment" do
      service = build_service

      expect(service.comment).to receive(:approve!).with(service.user)

      service.call
    end
  end

  def build_service
    comment = create(:comment)
    user = create(:user)

    described_class.new(comment, user)
  end
end
