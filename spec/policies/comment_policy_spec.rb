require "rails_helper"

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }
  let(:comment) { create(:comment, community: community) }

  context "for visitor" do
    let(:user) { nil }

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
    let(:user) { create(:user) }

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
    let(:user) { comment.user }

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
    let(:user) { create(:moderator, community: community).user }

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