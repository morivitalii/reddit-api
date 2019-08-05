require "rails_helper"

RSpec.describe SubPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  context "for visitor" do
    let(:user) { nil }

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    permissions :show? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end