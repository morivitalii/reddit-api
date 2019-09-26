require "rails_helper"

RSpec.describe PageNotFoundPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :show? do
      it { is_expected.to permit(context) }
    end
  end
end
