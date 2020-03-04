require "rails_helper"

RSpec.describe Api::Communities::ModQueues::Reports::PostsPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    permissions :index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    permissions :index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end
end
