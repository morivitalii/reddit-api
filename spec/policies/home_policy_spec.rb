require "rails_helper"

RSpec.describe HomePolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end
end