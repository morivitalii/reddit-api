require "rails_helper"

RSpec.describe CommunityPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for follower", context: :follower do
    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end