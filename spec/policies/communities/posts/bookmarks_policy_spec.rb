require "rails_helper"

RSpec.describe Communities::Posts::BookmarksPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end
