require "rails_helper"

RSpec.describe DeleteFollowService do
  subject { described_class.new(sub, user) }

  let!(:sub) { create(:sub) }
  let!(:user) { create(:user) }
  let!(:follow) { create(:follow, user: user, sub: sub) }

  describe ".call" do
    it "delete follow" do
      expect { subject.call }.to change { Follow.count }.by(-1)
    end
  end
end