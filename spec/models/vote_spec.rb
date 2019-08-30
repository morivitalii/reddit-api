require "rails_helper"

RSpec.describe Vote do
  subject { described_class }

  it_behaves_like "paginatable"

  context "validations" do
    subject { create(:vote) }

    it { is_expected.to define_enum_for(:vote_type).with_values(up: 1, down: -1) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to([:votable_type, :votable_id]) }
    it { is_expected.to validate_presence_of(:vote_type) }
  end

  shared_examples "votable counters cache updates" do
    context "and :vote_type is :up" do
      context "on create" do
        it "increments votable :up_votes_count" do
          vote = build(:up_vote, votable: votable)

          expect { vote.save! }.to change { votable.up_votes_count }.by(1)
        end
      end

      context "on destroy" do
        it "decrements votable :up_votes_count" do
          vote = create(:up_vote, votable: votable)

          expect { vote.destroy! }.to change { votable.up_votes_count }.by(-1)
        end
      end
    end

    context "and :vote_type is :down" do
      context "on create" do
        it "increments votable :down_votes_count" do
          vote = build(:down_vote, votable: votable)

          expect { vote.save! }.to change { votable.down_votes_count }.by(1)
        end
      end

      context "on destroy" do
        it "decrements votable :down_votes_count" do
          vote = create(:down_vote, votable: votable)

          expect { vote.destroy! }.to change { votable.down_votes_count }.by(-1)
        end
      end
    end
  end

  shared_examples "votable scores update" do
    context "on create" do
      it "calls .recalculate_scores! on votable" do
        vote = build(:vote, votable: votable)
        allow(votable).to receive(:recalculate_scores!)

        vote.save!

        expect(votable).to have_received(:recalculate_scores!).once
      end
    end

    context "on destroy" do
      it "calls .recalculate_scores! on votable" do
        vote = create(:vote, votable: votable)
        allow(votable).to receive(:recalculate_scores!)

        vote.destroy!

        expect(votable).to have_received(:recalculate_scores!).once
      end
    end
  end

  context "when votable is post" do
    let(:votable) { create(:post) }

    include_examples "votable counters cache updates"
    include_examples "votable scores update"
  end

  context "when votable is comment" do
    let(:votable) { create(:comment) }

    include_examples "votable counters cache updates"
    include_examples "votable scores update"
  end
end