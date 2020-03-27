require "rails_helper"

RSpec.describe Api::Users::Posts::Controversial::AllPolicy do
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

  context "as account owner", context: :as_signed_in_user do
    permissions :index? do
      it { is_expected.to permit(context, context.user) }
    end
  end
end
