require "rails_helper"

RSpec.describe Post do
  subject { described_class }

  describe "validations" do
    subject { build(:post) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:removed_reason).is_at_most(5_000) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(10_000) }
  end

  describe ".update_scores!" do
    it "updates post scores" do
      post = create(:post)
      allow(post).to receive(:update!)

      post.update_scores!

      expect(post).to have_received(:update!).with(
        new_score: anything,
        hot_score: anything,
        top_score: anything,
        controversy_score: anything
      )
    end
  end
end
