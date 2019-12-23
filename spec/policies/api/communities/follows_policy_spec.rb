require "rails_helper"

RSpec.describe Api::Communities::FollowsPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for follower", context: :user do
    before { create(:follow, user: context.user, community: context.community) }

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end
