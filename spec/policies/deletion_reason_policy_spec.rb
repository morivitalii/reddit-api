require "rails_helper"

RSpec.describe DeletionReasonPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }
  let(:deletion_reason) { create(:deletion_reason, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context, deletion_reason) }
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

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context, deletion_reason) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, sub: sub).user }

    permissions :index?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(context, deletion_reason) }
    end
  end
end