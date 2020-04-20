require "rails_helper"

RSpec.describe Api::ExilesPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:exile) { create(:exile) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, exile) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, exile) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:exile) { create(:exile) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, exile) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, exile) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:exile) { create(:exile) }

    permissions :index?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show?, :destroy? do
      it { is_expected.to permit(context, exile) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:exile) { create(:exile) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show?, :destroy? do
      it { is_expected.to_not permit(context, exile) }
    end
  end
end
