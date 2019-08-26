require "rails_helper"

RSpec.describe CommunityPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_update).to contain_exactly(:title, :description)
    end
  end

  def build_policy
    described_class.new(Context.new(nil), nil)
  end
end