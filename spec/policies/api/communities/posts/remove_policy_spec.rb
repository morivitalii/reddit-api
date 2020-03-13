require "rails_helper"

RSpec.describe Api::Communities::Posts::RemovePolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:post) { create(:post, community: context.community) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:post) { create(:post, community: context.community) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:post) { create(:post, community: context.community) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as author user", context: :as_signed_in_user do
    let(:post) { create(:post, created_by: context.user) }

    permissions :edit?, :update? do
      it { is_expected.to permit(context, post) }
    end

    permissions :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  describe ".permitted_attributes_for_update" do
    context "as moderator user", context: :as_moderator_user do
      it "contains attributes" do
        post = create(:post, community: context.community)
        policy = described_class.new(context, post)

        expect(policy.permitted_attributes_for_update).to contain_exactly(:reason)
      end
    end

    context "as author user", context: :as_signed_in_user do
      it "does not contain attributes" do
        post = create(:post, created_by: context.user)
        policy = described_class.new(context, post)

        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end
  end
end
