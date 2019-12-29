require "rails_helper"

RSpec.describe Api::CommunitiesPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :show? do
      it { is_expected.to permit(user) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :show? do
      it { is_expected.to permit(user) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(user_context) }
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_update).to contain_exactly(:title, :description)
    end
  end
end
