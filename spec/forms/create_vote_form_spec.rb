require "rails_helper"

RSpec.describe CreateVoteForm, type: :form do
  subject { described_class }

  describe ".save" do
    let(:user) { create(:user) }
    let(:votable) { create(:comment) }
    let(:vote_type) { "up" }
    let!(:vote) { create(:down_vote, votable: votable, user: user) }

    before do
      @form = subject.new(
        votable: votable,
        user: user,
        type: vote_type
      )
    end

    it "creates new vote" do
      @form.save

      expected_attributes = { votable: votable, user: user, vote_type: vote_type}
      result = @form.vote

      expect(result).to have_attributes(expected_attributes)
    end

    # TODO Destroy previous vote if exists
  end
end