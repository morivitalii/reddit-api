require "rails_helper"

RSpec.describe DeleteVoteService do
  subject { described_class.new(votable, user) }

  let!(:vote) { create(:vote) }
  let!(:votable) { vote.votable }
  let!(:user) { vote.user }

  describe ".call" do
    it "delete vote" do
      expect { subject.call }.to change { Vote.count }.by(-1)
    end
  end
end