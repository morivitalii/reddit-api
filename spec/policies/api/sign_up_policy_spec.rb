require "rails_helper"

RSpec.describe Api::SignUpPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    permissions :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    permissions :create? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as admin user", context: :as_admin_user do
    permissions :create? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    permissions :create? do
      it { is_expected.to_not permit(context) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes_for_create).to contain_exactly(:username, :email, :password)
    end
  end
end
