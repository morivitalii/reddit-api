require "rails_helper"

RSpec.describe Api::Communities::Posts::ApprovePolicy do
  subject { described_class }

  let(:post) { create(:post, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for user", context: :user do
    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :update? do
      it { is_expected.to permit(context, post) }
    end
  end
end
