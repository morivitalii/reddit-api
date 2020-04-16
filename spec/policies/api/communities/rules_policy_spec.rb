require "rails_helper"

RSpec.describe Api::Communities::RulesPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:rule) { create(:rule) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to_not permit(context, rule) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:rule) { create(:rule) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to_not permit(context, rule) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:rule) { create(:rule) }

    permissions :index?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to permit(context, rule) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:rule) { create(:rule) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to_not permit(context, rule) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:rule) { create(:rule, community: context.community) }

    permissions :index?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to permit(context, rule) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:rule) { create(:rule, community: context.community) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to_not permit(context, rule) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:rule) { create(:rule, community: context.community) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update?, :destroy? do
      it { is_expected.to_not permit(context, rule) }
    end
  end

  describe ".permitted_attributes" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes).to contain_exactly(:title, :description)
    end
  end
end
