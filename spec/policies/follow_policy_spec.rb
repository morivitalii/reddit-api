require "rails_helper"

RSpec.describe FollowPolicy, type: :policy do
  subject { described_class }
  
  context "for visitor" do
    include_context "visitor context"

    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for follower" do
    include_context "follower context"

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end