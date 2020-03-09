require "rails_helper"

RSpec.describe HomePolicy do
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
end
