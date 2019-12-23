require "rails_helper"

RSpec.describe Api::SignOutPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end
