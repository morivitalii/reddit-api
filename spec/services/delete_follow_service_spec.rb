require "rails_helper"

RSpec.describe DeleteFollowService do
  subject { described_class }

  describe ".call" do
    let!(:community) { create(:community) }
    let!(:user) { create(:user) }
    let!(:follow) { create(:follow, user: user, community: community) }

    before do
      @service = subject.new(community, user)
    end

    it "delete follow" do
      expect { @service.call }.to change { Follow.count }.by(-1)
    end
  end
end