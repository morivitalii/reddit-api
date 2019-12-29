require "rails_helper"

RSpec.describe Api::Communities::Posts::RemovePolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(user, post) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(user, post) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    let(:post) { create(:post, community: user_context.community) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to permit(user_context, post) }
    end
  end

  context "for author", context: :as_signed_in_user do
    let(:post) { create(:post, user: user) }

    permissions :edit?, :update? do
      it { is_expected.to permit(user, post) }
    end

    permissions :update_reason? do
      it { is_expected.to_not permit(user, post) }
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for moderator", context: :as_moderator_user do
      it "contains attributes" do
        post = create(:post, community: user_context.community)
        policy = described_class.new(user_context, post)

        expect(policy.permitted_attributes_for_update).to contain_exactly(:reason)
      end
    end

    context "for author", context: :as_signed_in_user do
      it "does not contain attributes" do
        post = create(:post, user: user)
        policy = described_class.new(user, post)

        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end
  end
end
