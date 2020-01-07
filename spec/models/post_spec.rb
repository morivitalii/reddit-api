require "rails_helper"

RSpec.describe Post do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "validations" do
    subject { build(:post) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:removed_reason).is_at_most(5_000) }

    context "text post" do
      subject { build(:text_post) }

      it { is_expected.to validate_length_of(:text).is_at_most(10_000) }
      # it { is_expected.to validate_absence_of(:file) }
    end

    context "image post" do
      subject { build(:image_post) }

      it { is_expected.to validate_absence_of(:text) }
    end
  end

  context "when author have permissions for approving" do
    it "approves post on create" do
      post = build(:post)
      allow(post).to receive(:author_has_permissions_to_approve?).and_return(true)

      post.save!

      expect(post.approved_by).to eq(post.created_by)
      expect(post.approved_at).to be_present
    end
  end

  context "when author have not permissions for approving" do
    it "does not approve post on create" do
      post = build(:post)
      allow(post).to receive(:author_has_permissions_to_approve?).and_return(false)

      post.save!

      expect(post.approved_by).to be_blank
      expect(post.approved_at).to be_blank
    end
  end

  context "when post is approved" do
    context "and when it is editing" do
      it "resets approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:editing?).and_return(true)

        post.save!

        expect(post.approved_by).to be_blank
        expect(post.approved_at).to be_blank
      end
    end

    context "and when it is not editing" do
      it "does not reset approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:editing?).and_return(false)

        post.save!

        expect(post.approved_by).to be_present
        expect(post.approved_at).to be_present
      end
    end

    context "and when it is removing" do
      it "resets approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:removing?).and_return(true)

        post.save!

        expect(post.approved_by).to be_blank
        expect(post.approved_at).to be_blank
      end
    end

    context "and when it is not removing" do
      it "does not reset approved attributes" do
        post = create(:approved_post)
        allow(post).to receive(:removing?).and_return(false)

        post.save!

        expect(post.approved_by).to be_present
        expect(post.approved_at).to be_present
      end
    end
  end

  context "when it is approving" do
    it "destroys reports" do
      post = create(:post_with_reports, reports_count: 2)
      allow(post).to receive(:approving?).and_return(true)

      post.save!

      expect(post.reports).to be_blank
    end
  end

  context "when it is removing" do
    it "destroys reports" do
      post = create(:post_with_reports, reports_count: 2)
      allow(post).to receive(:removing?).and_return(true)

      post.save!

      expect(post.reports).to be_blank
    end
  end

  describe ".approved?" do
    context "when post is approved" do
      it "returns true" do
        post = build(:approved_post)

        expect(post).to be_approved
      end
    end

    context "when post is not approved" do
      it "returns false" do
        post = build(:not_approved_post)

        expect(post).to_not be_approved
      end
    end
  end

  describe ".removed?" do
    context "when post is not removed" do
      it "returns false" do
        post = build(:not_removed_post)

        expect(post).to_not be_removed
      end
    end

    context "when post is removed" do
      it "returns true" do
        post = build(:removed_post)

        expect(post).to be_removed
      end
    end
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
