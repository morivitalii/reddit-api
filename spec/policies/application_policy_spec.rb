require "rails_helper"

RSpec.describe ApplicationPolicy do
  subject { described_class }

  describe ".initialize" do
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

  describe ".skip_rate_limiting?" do
    context "as signed out user", context: :as_signed_out_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(context) }
      end
    end

    context "as signed in user", context: :as_signed_in_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(context) }
      end
    end

    context "as moderator user", context: :as_moderator_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to permit(context) }
      end
    end

    context "as muted user", context: :as_muted_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(context) }
      end
    end

    context "for banned user", context: :as_banned_user do
      permissions :skip_rate_limiting? do
        it { is_expected.to_not permit(context) }
      end
    end
  end
end
