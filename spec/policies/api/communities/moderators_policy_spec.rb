require "rails_helper"

RSpec.describe Api::Communities::ModeratorsPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    permissions :index?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes_for_create).to contain_exactly(:username)
    end
  end
end
