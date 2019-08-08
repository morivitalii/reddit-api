require "rails_helper"

RSpec.shared_examples_for "votable" do
  let(:model) { create(described_class.to_s.underscore.to_sym) }

  describe ".votable?" do
    it { is_expected.to be_truthy }
  end

  describe ".create_self_up_vote" do
    let(:model) { build(described_class.to_s.underscore.to_sym) }

    it "creates up vote on create" do
      model.save!

      result = model.votes.take
      expected_attributes = { votable: model, user: model.user, vote_type: "up" }

      expect(result).to have_attributes(expected_attributes)
    end
  end

  describe ".update_scores!" do
    it "updates model scores attributes" do
      expected_new_score = 0
      expected_hot_score = 0
      expected_best_score = 0
      expected_top_score = 0
      expected_controversy_score = 0

      allow(model).to receive(:calculate_new_score).and_return(expected_new_score)
      allow(model).to receive(:calculate_hot_score).and_return(expected_hot_score)
      allow(model).to receive(:calculate_best_score).and_return(expected_best_score)
      allow(model).to receive(:calculate_top_score).and_return(expected_top_score)
      allow(model).to receive(:calculate_controversy_score).and_return(expected_controversy_score)

      expect(model).to receive(:update!).with(
        new_score: expected_new_score,
        hot_score: expected_hot_score,
        best_score: expected_best_score,
        top_score: expected_top_score,
        controversy_score: expected_controversy_score
      ).once

      model.update_scores!
    end
  end
end