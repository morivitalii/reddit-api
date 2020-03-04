require "rails_helper"

RSpec.describe Api::CommunitiesPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:community) { create(:community) }

    permissions :index? do
      it { is_expected.to permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, community) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, community) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    let(:community) { create(:community) }

    permissions :index?, :create? do
      it { is_expected.to permit(user) }
    end

    permissions :show? do
      it { is_expected.to permit(user) }
    end

    permissions :update? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    permissions :index?, :create? do
      it { is_expected.to permit(user_context) }
    end

    permissions :show?, :update? do
      it { is_expected.to permit(user_context, user_context.community) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_create).to contain_exactly(:url, :title, :description)
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_update).to contain_exactly(:title, :description)
    end
  end
end
