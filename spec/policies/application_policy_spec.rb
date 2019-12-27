require "rails_helper"

RSpec.describe ApplicationPolicy do
  subject { described_class }

  describe ".initialize" do
    context "when pundit_user is current_user" do
      it "sets user and record instance variables" do
        user = create(:user)
        record = double(:record)

        policy = described_class.new(user, record)

        expect(policy.user).to eq(user)
        expect(policy.community).to be_nil
        expect(policy.record).to eq(record)
      end
    end

    context "when pundit_user is Context instance" do
      it "sets user, community and record instance variables" do
        user = create(:user)
        community = create(:community)
        context = Context.new(user, community)
        record = double(:record)

        policy = described_class.new(context, record)

        expect(policy.user).to eq(user)
        expect(policy.community).to eq(community)
        expect(policy.record).to eq(record)
      end
    end
  end

  describe ".skip_rate_limiting?" do
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
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(context) }
      end
    end
  end
end
