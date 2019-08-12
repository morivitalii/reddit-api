require "rails_helper"

RSpec.describe DeleteVoteService do
  subject { described_class }

  describe ".call" do
    let!(:vote) { create(:vote) }
    let!(:votable) { vote.votable }
    let!(:user) { vote.user }

    before do
      @service = subject.new(votable, user)
    end

    it "delete vote" do
      expect { @service.call }.to change { Vote.count }.by(-1)
    end
  end
end