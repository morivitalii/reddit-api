require "rails_helper"

RSpec.describe Api::Users::Communities::BansPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to permit(context, user) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to permit(context, user) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to permit(context, user) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to_not permit(context, user) }
    end
  end
end
