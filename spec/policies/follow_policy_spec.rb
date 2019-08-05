require "rails_helper"

RSpec.describe FollowPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }
  
  context "for visitor" do
    let(:user) { nil }

    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "follower" do
      before { create(:follow, user: user, sub: sub) }

      permissions :create? do
        it { is_expected.to_not permit(context) }
      end

      permissions :destroy? do
        it { is_expected.to permit(context) }
      end
    end

    context "not follower" do
      permissions :create? do
        it { is_expected.to permit(context) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(context) }
      end
    end
  end
end