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
end