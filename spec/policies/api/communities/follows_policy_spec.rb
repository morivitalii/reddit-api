require "rails_helper"

RSpec.describe Api::Communities::FollowsPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :create? do
      it { is_expected.to permit(user) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for follower", context: :as_signed_in_user do
    let(:follow) { create(:follow, user: user) }

    permissions :create? do
      it do
        context = Context.new(user, follow.community)

        is_expected.to_not permit(context)
      end
    end

    permissions :destroy? do
      it do
        context = Context.new(user, follow.community)

        is_expected.to permit(context)
      end
    end
  end
end
