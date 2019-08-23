require "rails_helper"

RSpec.describe ModeratorPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :index?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end