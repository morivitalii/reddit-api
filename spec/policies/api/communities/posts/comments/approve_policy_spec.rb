require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::ApprovePolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to permit(context, comment) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:comment) { create(:comment, community: context.community) }

    permissions :update? do
      it { is_expected.to permit(context, comment) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:comment) { create(:comment, community: context.community) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:comment) { create(:comment, community: context.community) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end
end
