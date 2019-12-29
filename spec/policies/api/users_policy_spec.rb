require "rails_helper"

RSpec.describe Api::UsersPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :update? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_update).to contain_exactly(:email, :password, :password_current)
    end
  end
end
