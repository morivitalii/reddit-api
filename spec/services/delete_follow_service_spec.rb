require "rails_helper"

RSpec.describe DeleteFollowService do
  subject { described_class }

  describe ".call" do
    let!(:sub) { create(:sub) }
    let!(:user) { create(:user) }
    let!(:follow) { create(:follow, user: user, sub: sub) }

    before do
      @service = subject.new(sub, user)
    end

    it "delete follow" do
      expect { @service.call }.to change { Follow.count }.by(-1)
    end
  end
end