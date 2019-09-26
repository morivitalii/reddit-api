require "rails_helper"

RSpec.describe SignInPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :new?, :create?, :unauthenticated? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :new?, :create?, :unauthenticated? do
      it { is_expected.to_not permit(context) }
    end
  end
end
