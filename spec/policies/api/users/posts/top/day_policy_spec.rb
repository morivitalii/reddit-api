require "rails_helper"

RSpec.describe Api::Users::Posts::Top::DayPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to permit(context, user) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    context "another user" do
      let(:another_user) { create(:user) }

      permissions :index? do
        it { is_expected.to permit(user, another_user) }
      end
    end

    context "account owner" do
      permissions :index? do
        it { is_expected.to permit(user, user) }
      end
    end
  end
end
