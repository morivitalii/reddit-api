require "rails_helper"

RSpec.describe Api::Communities::Posts::RemovePolicy do
  subject { described_class }

  let(:post) { create(:post, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for user", context: :user do
    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :edit?, :update?, :update_reason? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "for author", context: :user do
    let(:post) { create(:post, user: context.user, community: context.community) }

    permissions :edit?, :update? do
      it { is_expected.to permit(context, post) }
    end

    permissions :update_reason? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for moderator", context: :moderator do
      it "contains attributes" do
        post = create(:post, community: context.community)
        policy = described_class.new(context, post)

        expect(policy.permitted_attributes_for_update).to contain_exactly(:reason)
      end
    end

    context "for author", context: :user do
      it "does not contain attributes" do
        post = create(:post, community: context.community, user: context.user)
        policy = described_class.new(context, post)

        expect(policy.permitted_attributes_for_update).to be_blank
      end
    end
  end
end
