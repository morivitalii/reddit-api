require "rails_helper"

RSpec.describe Api::SignOutPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :destroy? do
      it { is_expected.to permit(user) }
    end
  end
end
