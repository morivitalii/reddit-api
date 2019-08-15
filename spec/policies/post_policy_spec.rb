require "rails_helper"

RSpec.describe PostPolicy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }
  let(:post) { create(:post, community: community) }

  context "for visitor" do
    let(:user) { nil }

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
    let(:user) { create(:user) }

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
    let(:user) { post.user }

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
    let(:user) { create(:moderator, community: community).user }

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