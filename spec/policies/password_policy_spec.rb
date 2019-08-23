require "rails_helper"

RSpec.describe PasswordPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end