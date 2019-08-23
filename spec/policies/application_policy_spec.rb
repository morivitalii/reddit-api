require "rails_helper"

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :skip_rate_limiting? do
      it { is_expected.to permit(context) }
    end
  end

  context "for banned", context: :banned do
    it "raises ApplicationPolicy::BannedError if user is banned" do
      expect { subject.new(context, nil) }.to raise_error(ApplicationPolicy::BannedError)
    end
  end
end