require "rails_helper"

RSpec.describe CreateVoteForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new
      end

      it "invalid if type does not included in allowed values" do
        @form.type = "wrong type"
        @form.save

        expected_result = { error: :inclusion, value: "wrong type" }
        result = @form.errors.details[:type]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      let(:user) { create(:user) }
      let(:votable) { create(:comment) }
      let(:vote_type) { "up" }

      before do
        @form = subject.new(
          votable: votable,
          user: user,
          type: vote_type
        )
      end

      context "vote does not exists" do
        it "creates vote" do
          @form.save

          expected_attributes = { votable: votable, user: user, vote_type: vote_type}
          result = @form.vote

          expect(result).to have_attributes(expected_attributes)
        end
      end

      context "vote exists" do
        let!(:vote) { create(:down_vote, votable: votable, user: user) }

        it "updates vote" do
          @form.save

          expected_attributes = { votable: votable, user: user, vote_type: vote_type}
          result = @form.vote

          expect(result).to have_attributes(expected_attributes)
        end
      end
    end
  end
end