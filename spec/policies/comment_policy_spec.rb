require "rails_helper"

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let(:comment) { create(:comment, community: context.community) }

  context "for visitor" do
    include_context "visitor context"

    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :show? do
      it { is_expected.to permit(context, comment) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for author" do
    include_context "user context"

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

    permissions :approve?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :show?, :edit?, :update?, :approve?, :remove?, :destroy?, :ignore_reports?, :deletion_reason? do
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