require "rails_helper"

RSpec.describe Api::Communities::RulesPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :index? do
      it { is_expected.to permit(user) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(user) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    permissions :index?, :new?, :create? do
      it { is_expected.to permit(user_context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(user_context) }
    end
  end

  describe ".permitted_attributes" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes).to contain_exactly(:title, :description)
    end
  end
end
