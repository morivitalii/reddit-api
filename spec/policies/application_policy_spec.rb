require "rails_helper"

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :skip_rate_limiting? do
      it { is_expected.to permit(context) }
    end
  end

  context "for banned user" do
    include_context "banned context"

    it "raises ApplicationPolicy::BannedError if user is banned" do
      expect { subject.new(context, nil) }.to raise_error(ApplicationPolicy::BannedError)
    end
  end
end