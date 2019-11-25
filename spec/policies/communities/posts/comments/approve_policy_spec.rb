require "rails_helper"

RSpec.describe Communities::Posts::Comments::ApprovePolicy do
  subject { described_class }

  let(:comment) { create(:comment, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for user", context: :user do
    permissions :update? do
      it { is_expected.to_not permit(context, comment) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :update? do
      it { is_expected.to permit(context, comment) }
    end
  end
end
