require "rails_helper"

RSpec.describe ChangePasswordPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_update).to contain_exactly(:token, :password)
    end
  end

  def build_policy
    described_class.new(Context.new(nil), nil)
  end
end