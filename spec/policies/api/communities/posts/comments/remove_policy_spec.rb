require "rails_helper"

RSpec.describe Api::Communities::Posts::Comments::RemovePolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:comment) { create(:comment) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(user, comment) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    let(:comment) { create(:comment) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(user, comment) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    let(:comment) { create(:comment, community: user_context.community) }

    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to permit(user_context, comment) }
    end
  end

  context "for author", context: :as_signed_in_user do
    let(:comment) { create(:comment, user: user) }

    permissions :edit?, :update? do
      it { is_expected.to permit(user, comment) }
    end

    permissions :update_reason? do
      it { is_expected.to_not permit(user, comment) }
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for moderator", context: :as_moderator_user do
      it "contains attributes" do
        comment = create(:comment, community: user_context.community)
        policy = described_class.new(user_context, comment)

        expect(policy.permitted_attributes_for_update).to contain_exactly(:reason)
      end
    end

    context "for author", context: :as_signed_in_user do
      it "does not contain attributes" do
        comment = create(:comment, user: user)
        policy = described_class.new(user, comment)

        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end
  end
end
