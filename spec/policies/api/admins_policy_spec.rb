require "rails_helper"

RSpec.describe Api::AdminsPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:admin) { create(:admin) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, admin) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, admin) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:admin) { create(:admin) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, admin) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, admin) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:admin) { create(:admin) }

    permissions :index?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show?, :destroy? do
      it { is_expected.to permit(context, admin) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:admin) { create(:admin) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show?, :destroy? do
      it { is_expected.to_not permit(context, admin) }
    end
  end
end