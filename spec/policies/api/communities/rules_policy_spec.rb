require "rails_helper"

RSpec.describe Api::Communities::RulesPolicy do
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

  describe ".permitted_attributes" do
    it "contains attributes" do
      policy = build_policy
      expect(policy.permitted_attributes).to contain_exactly(:title, :description)
    end
  end

  def build_policy
    described_class.new(Context.new(nil, nil), nil)
  end
end
