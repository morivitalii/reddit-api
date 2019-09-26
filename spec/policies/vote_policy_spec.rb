require "rails_helper"

RSpec.describe VotePolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index?, :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      let(:user) { create(:user) }

      it { is_expected.to_not permit(context, user) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  context "for owner", context: :user do
    permissions :index? do
      let(:user) { context.user }

      it { is_expected.to permit(context, user) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_create).to contain_exactly(:type)
    end
  end

  def build_policy
    described_class.new(Context.new(nil), nil)
  end
end
