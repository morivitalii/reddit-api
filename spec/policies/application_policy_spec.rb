require "rails_helper"

RSpec.describe ApplicationPolicy do
  subject { described_class }

  describe ".initialize" do
    context "when pundit_user is User instance" do
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
    context "for signed out user", context: :as_signed_out_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(user) }
      end
    end

    context "for signed in user", context: :as_signed_in_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(user) }
      end
    end

    context "for moderator", context: :as_moderator_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to permit(user_context) }
      end
    end

    context "for banned", context: :as_banned_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(user_context) }
      end
    end
  end
end
