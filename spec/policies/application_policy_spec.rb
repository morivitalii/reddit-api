require "rails_helper"

RSpec.describe ApplicationPolicy do
  subject { described_class }

  describe ".initialize" do
    it "sets user and record instance variables" do
      user = instance_double(User)
      context = instance_double(Context, user: user, community: nil)
      record = double(:record, community: nil)

      policy = described_class.new(context, record)

      expect(policy.record).to eq(record)
      expect(policy.user).to eq(user)
    end

    context "community instance variable" do
      context "when record does not have community variable" do
        it "sets community instance variable from context" do
          context_community = instance_double(Community)
          context = instance_double(Context, user: nil, community: context_community)

          record_community = nil
          record = double(:record, community: record_community)

          policy = described_class.new(context, record)

          expect(policy.community).to eq(context_community)
        end
      end

      context "when record has community variable" do
        it "sets community instance variable from record" do
          context_community = instance_double(Community)
          context = instance_double(Context, user: nil, community: context_community)

          record_community = instance_double(Community)
          record = double(:record, community: record_community)

          policy = described_class.new(context, record)

          expect(policy.community).to eq(record_community)
        end
      end
    end

    context "for banned", context: :banned do
      it "raises ApplicationPolicy::BannedError if user is banned" do
        expect { described_class.new(context, nil) }.to raise_error(ApplicationPolicy::BannedError)
      end
    end
  end

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
end
