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

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :explicit?, :spoiler?, :ignore_reports?, :removed_reason? do
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

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :explicit?, :spoiler?, :ignore_reports?, :removed_reason? do
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

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :explicit?, :spoiler?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :edit?, :update?, :approve?, :remove?, :destroy?, :explicit?, :spoiler?, :ignore_reports?, :removed_reason? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :text? do
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

    permissions :edit?, :update?, :remove?, :destroy?, :text? do
      it { is_expected.to permit(context, post) }
    end

    permissions :approve?, :explicit?, :spoiler?, :ignore_reports?, :removed_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end
end