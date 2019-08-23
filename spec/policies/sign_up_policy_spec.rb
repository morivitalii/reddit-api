require "rails_helper"

RSpec.describe SignUpPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end
  end
end