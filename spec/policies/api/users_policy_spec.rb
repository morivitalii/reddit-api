require "rails_helper"

RSpec.describe Api::UsersPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :show? do
      it { is_expected.to permit(user) }
    end

    permissions :update? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :show?, :update? do
      it { is_expected.to permit(user) }
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_update).to contain_exactly(:email, :password)
    end
  end
end
