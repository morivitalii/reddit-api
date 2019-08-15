require "rails_helper"

RSpec.describe FollowPolicy, type: :policy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }
  
  context "for visitor" do
    let(:user) { nil }

    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for follower user" do
    let(:user) { create(:follow, community: community).user }

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  context "for not follower user" do
    let(:user) { create(:user) }

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end
end