require "rails_helper"

RSpec.describe SubPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  context "for visitor" do
    let(:user) { nil }

    permissions :show? do
      it { is_expected.to permit(context, sub) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, sub) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :show? do
      it { is_expected.to permit(context, sub) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, sub) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, sub: sub).user }

    permissions :show?, :edit?, :update? do
      it { is_expected.to permit(context, sub) }
    end
  end
end