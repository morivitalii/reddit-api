require "rails_helper"

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  let(:post) { create(:post, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :update_text?, :update_explicit?, :update_spoiler?, :update_ignore_reports?, :update_removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for user", context: :user do
    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :update_text?, :update_explicit?, :update_spoiler?, :update_ignore_reports?, :update_removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for follower", context: :follower do
    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :update_text?, :update_explicit?, :update_spoiler?, :update_ignore_reports?, :update_removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :edit?, :update?, :approve?, :remove?, :destroy?, :update_explicit?, :update_spoiler?, :update_ignore_reports?, :update_removed_reason? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :update_text? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for author", context: :user do
    let(:post) { create(:post, user: context.user, community: context.community) }

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :remove?, :destroy?, :update_text? do
      it { is_expected.to permit(context, post) }
    end

    permissions :approve?, :update_explicit?, :update_spoiler?, :update_ignore_reports?, :update_removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  describe ".permitted_attributes_for_create", context: :user do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_create).to contain_exactly(:title, :text, :url, :image, :explicit, :spoiler)
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for moderator", context: :moderator do
      it "contains attributes" do
        post = create(:post, community: context.community)
        policy = build_policy(post)
        expect(policy.permitted_attributes_for_update).to contain_exactly(:explicit, :spoiler, :ignore_reports)
      end
    end

    context "for author", context: :user do
      it "contains attributes" do
        post = create(:post, community: context.community, user: context.user)
        policy = build_policy(post)
        expect(policy.permitted_attributes_for_update).to contain_exactly(:text)
      end
    end
  end

  describe ".permitted_attributes_for_destroy" do
    context "for moderator", context: :moderator do
      it "contains attributes" do
        post = create(:post, community: context.community)
        policy = build_policy(post)
        expect(policy.permitted_attributes_for_destroy).to contain_exactly(:reason)
      end
    end

    context "for author", context: :user do
      it "contains attributes" do
        post = create(:post, community: context.community, user: context.user)
        policy = build_policy(post)
        expect(policy.permitted_attributes_for_destroy).to be_blank
      end
    end
  end

  def build_policy(post = nil)
    described_class.new(context, post)
  end
end