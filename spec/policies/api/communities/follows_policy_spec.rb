require "rails_helper"

RSpec.describe Api::Communities::FollowsPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as admin user", context: :as_admin_user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as muted user", context: :as_muted_user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for follower", context: :as_signed_in_user do
    let(:follow) { create(:follow, user: context.user) }

    permissions :create? do
      it do
        new_context = Context.new(context.user, follow.community)

        is_expected.to_not permit(new_context)
      end
    end

    permissions :destroy? do
      it do
        new_context = Context.new(context.user, follow.community)

        is_expected.to permit(new_context)
      end
    end
  end
end
