require "rails_helper"

RSpec.describe CommunityPolicy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  context "for visitor" do
    let(:user) { nil }

    permissions :show? do
      it { is_expected.to permit(context, community) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, community) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :show? do
      it { is_expected.to permit(context, community) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, community) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, community: community).user }

    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(context, community) }
    end
  end
end