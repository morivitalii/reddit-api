require "rails_helper"

RSpec.describe Api::Communities::PostsPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:post) { create(:post) }

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as exiled user", context: :as_exiled_user do
    let(:post) { create(:post) }

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to_not permit(context, post) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:post) { create(:post, community: context.community) }

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:post) { create(:post, community: context.community) }

    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:post) { create(:post, community: context.community) }

    permissions :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show?, :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as author user", context: :as_signed_in_user do
    let(:post) { create(:post, created_by: context.user) }

    permissions :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show?, :update? do
      it { is_expected.to permit(context, post) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes_for_create).to contain_exactly(:title, :text, :explicit, :spoiler)
    end
  end

  describe ".permitted_attributes_for_update" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes_for_update).to contain_exactly(:text)
    end
  end
end
