require "rails_helper"

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  it "raises ApplicationPolicy::BannedError if user is banned" do
    ban = create(:ban)

    expect { ApplicationPolicy.new(Context.new(ban.user, ban.community), nil) }.to raise_error(ApplicationPolicy::BannedError)
  end

  context "for visitor" do
    let(:user) { nil }

    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :skip_rate_limiting? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, community: community).user }

    permissions :skip_rate_limiting? do
      it { is_expected.to permit(context) }
    end
  end
end