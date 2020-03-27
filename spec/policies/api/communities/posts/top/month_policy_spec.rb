require "rails_helper"

RSpec.describe Api::Communities::Posts::Top::MonthPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "as admin user", context: :as_admin_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "as muted user", context: :as_muted_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "as banned user", context: :as_banned_user do
    permissions :index? do
      it { is_expected.to_not permit(context) }
    end
  end
end
