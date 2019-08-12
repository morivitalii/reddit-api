require "rails_helper"

RSpec.describe BlacklistedDomainPolicy do
  subject { described_class }

  let(:context) { Context.new(user, sub) }
  let(:sub) { create(:sub) }
  let(:blacklisted_domain) { create(:blacklisted_domain, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, blacklisted_domain) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to_not permit(context, blacklisted_domain) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, sub: sub).user }

    permissions :index?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :destroy? do
      it { is_expected.to permit(context, blacklisted_domain) }
    end
  end
end