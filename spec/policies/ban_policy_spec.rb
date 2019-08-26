require "rails_helper"

RSpec.describe BanPolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :index?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_create).to contain_exactly(:username, :reason, :days, :permanent)
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_update).to contain_exactly(:reason, :days, :permanent)
    end
  end

  def build_policy
    described_class.new(Context.new(nil), nil)
  end
end