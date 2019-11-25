require "rails_helper"

RSpec.describe Communities::Posts::ApproveService do
  describe ".call" do
    it "approves post" do
      service = build_service

      expect(service.post).to receive(:approve!).with(service.user)

      service.call
    end
  end

  def build_service
    post = create(:post)
    user = create(:user)

    described_class.new(post, user)
  end
end
