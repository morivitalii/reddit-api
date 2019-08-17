require "rails_helper"

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  let(:post) { create(:post, community: context.community) }

  context "for visitor" do
    include_context "visitor context"

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :explicit?, :spoiler?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :approve?, :remove?, :destroy?, :text?, :explicit?, :spoiler?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for author" do
    include_context "user context"

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

    permissions :approve?, :explicit?, :spoiler?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :show?, :edit?, :update?, :approve?, :remove?, :destroy?, :explicit?, :spoiler?, :ignore_reports?, :deletion_reason? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :text? do
      it { is_expected.to_not permit(context, post) }
    end
  end
end