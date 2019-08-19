require "rails_helper"

RSpec.describe DeleteFollowService do
  subject { described_class }

  describe ".call" do
    it "deletes follow" do
      service = build_delete_follow_service

      expect { service.call }.to change { Follow.count }.by(-1)
    end
  end

  def build_delete_follow_service
    community = create(:community)
    user = create(:user)
    create(:follow, community: community, user: user)

    described_class.new(community, user)
  end
end