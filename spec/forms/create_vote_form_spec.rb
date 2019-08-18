require "rails_helper"

RSpec.describe CreateVoteForm, type: :form do
  subject { described_class }

  shared_examples "vote already exists" do
    context "and when vote already exists" do
      it "deletes it" do
        form = build_create_vote_form(votable)
        previous_vote = instance_double(Vote, destroy!: nil)
        allow(form).to receive(:previous_vote).and_return(previous_vote)

        form.save

        expect(previous_vote).to have_received(:destroy!)
      end
    end
  end

  shared_examples "vote creation" do
    context "and when vote does not exists" do
      it "creates vote" do
        form = build_create_vote_form(votable)

        expect { form.save }.to change { Vote.count }.by(1)
      end
    end
  end

  describe ".save" do
    context "when votable is post" do
      let(:votable) { create(:comment) }

      include_examples "vote already exists"
      include_examples "vote creation"
    end

    context "when votable is comment" do
      let(:votable) { create(:post) }

      include_examples "vote already exists"
      include_examples "vote creation"
    end
  end

  def build_create_vote_form(votalbe)
    user = create(:user)

    subject.new(
      votable: votalbe,
      user: user,
      type: :up
    )
  end
end