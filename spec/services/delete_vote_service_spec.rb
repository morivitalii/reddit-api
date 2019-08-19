require "rails_helper"

RSpec.describe DeleteVoteService do
  subject { described_class }

  shared_examples "vote deletion" do
    it "deletes vote" do
      service = build_delete_vote_service(votable)

      expect { service.call }.to change { Vote.count }.by(-1)
    end
  end

  describe ".call" do
    context "when votable is post" do
      let(:votable) { create(:post) }

      include_examples "vote deletion"
    end

    context "when votable is comment" do
      let(:votable) { create(:comment) }

      include_examples "vote deletion"
    end
  end

  def build_delete_vote_service(votable)
    user = create(:user)
    create(:vote, votable: votable, user: user)

    described_class.new(votable, user)
  end
end