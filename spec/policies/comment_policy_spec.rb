require "rails_helper"

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let(:comment) { create(:comment, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for user", context: :user do
    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for follower", context: :follower do
    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :edit?, :update?, :approve?, :remove?, :destroy?, :ignore_reports?, :removed_reason? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :text? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for author", context: :user do
    let(:comment) { create(:comment, user: context.user, community: context.community) }

    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :remove?, :destroy?, :text? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :approve?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  describe ".permitted_attributes_for_create", context: :user do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_create).to contain_exactly(:text)
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for user", context: :user do
      it "contains attributes" do
        comment = create(:comment)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end

    context "for follower", context: :follower do
      it "contains attributes" do
        comment = create(:comment, community: context.community)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end

    context "for moderator", context: :moderator do
      it "contains attributes" do
        comment = create(:comment, community: context.community)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_update).to contain_exactly(:ignore_reports)
      end
    end

    context "for author", context: :user do
      it "contains attributes" do
        comment = create(:comment, community: context.community, user: context.user)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_update).to contain_exactly(:text)
      end
    end
  end

  describe ".permitted_attributes_for_destroy" do
    context "for user", context: :user do
      it "contains attributes" do
        comment = create(:comment)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_destroy).to be_blank
      end
    end

    context "for follower", context: :follower do
      it "contains attributes" do
        comment = create(:comment, community: context.community)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_destroy).to be_blank
      end
    end

    context "for moderator", context: :moderator do
      it "contains attributes" do
        comment = create(:comment, community: context.community)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_destroy).to contain_exactly(:reason)
      end
    end

    context "for author", context: :user do
      it "contains attributes" do
        comment = create(:comment, community: context.community, user: context.user)
        policy = build_policy(comment)
        expect(policy.permitted_attributes_for_destroy).to be_blank
      end
    end
  end

  def build_policy(comment = nil)
    described_class.new(context, comment)
  end
end