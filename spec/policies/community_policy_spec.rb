require "rails_helper"

RSpec.describe CommunityPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end