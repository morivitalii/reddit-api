require "rails_helper"

RSpec.describe Api::Communities::Posts::ApprovePolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:post) { create(:post) }

    permissions :update? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:post) { create(:post) }

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:post) { create(:post, community: context.community) }

    permissions :update? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:post) { create(:post, community: context.community) }

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:post) { create(:post, community: context.community) }

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end
end
