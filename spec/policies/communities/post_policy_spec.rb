require "rails_helper"

RSpec.describe Communities::PostsPolicy do
  subject { described_class }

  let(:post) { create(:post, community: context.community) }

  context "for visitor", context: :visitor do
    permissions :show? do
      it { is_expected.to permit(context, post) }
    end

    permissions :new_text?, :new_link?, :new_image?, :create?, :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(context, post) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(context, post) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "for author", context: :user do
    let(:post) { create(:post, user: context.user, community: context.community) }

    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(context, post) }
    end

    context "text post" do
      let(:post) { create(:text_post, user: context.user, community: context.community) }

      permissions :edit?, :update? do
        it { is_expected.to permit(context, post) }
      end
    end

    context "link post" do
      let(:post) { create(:link_post, user: context.user, community: context.community) }

      permissions :edit?, :update? do
        it { is_expected.to_not permit(context, post) }
      end
    end

    context "image post" do
      let(:post) { create(:image_post, user: context.user, community: context.community) }

      permissions :edit?, :update? do
        it { is_expected.to_not permit(context, post) }
      end
    end
  end

  describe ".permitted_attributes_for_create", context: :user do
    it "contains :title, :text, :url, :image, :explicit and :spoiler attributes" do
      policy = build_policy
      expect(policy.permitted_attributes_for_create).to contain_exactly(:title, :text, :url, :image, :explicit, :spoiler)
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for author", context: :user do
      it "contains :text attribute" do
        post = create(:post, community: context.community, user: context.user)
        policy = build_policy(post)
        expect(policy.permitted_attributes_for_update).to contain_exactly(:text)
      end
    end
  end

  def build_policy(post = nil)
    described_class.new(context, post)
  end
end
