require "rails_helper"

RSpec.describe BookmarkPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index?, :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      let(:user) { create(:user) }

      it { is_expected.to_not permit(context, user) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  context "for owner", context: :user do
    permissions :index? do
      let(:user) { context.user }

      it { is_expected.to permit(context, user) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end