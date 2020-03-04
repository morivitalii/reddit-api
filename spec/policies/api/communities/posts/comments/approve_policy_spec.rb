require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::ApprovePolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    let(:comment) { create(:comment) }

    permissions :update? do
      it { is_expected.to_not permit(user, comment) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    let(:comment) { create(:comment, community: user_context.community) }

    permissions :update? do
      it { is_expected.to permit(user_context, comment) }
    end
  end
end
