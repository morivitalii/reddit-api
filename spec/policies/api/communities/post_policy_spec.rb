require "rails_helper"

RSpec.describe Api::Communities::PostsPolicy do
  subject { described_class }

  context "for signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :show? do
      it { is_expected.to permit(user, post) }
    end

    permissions :new_text?, :new_link?, :new_image?, :create?, :edit?, :update? do
      it { is_expected.to_not permit(user) }
    end
  end

  context "for signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(user, post) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(user, post) }
    end
  end

  context "for moderator", context: :as_moderator_user do
    let(:post) { create(:post, community: user_context.community) }

    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(user_context, post) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(user_context, post) }
    end
  end

  context "for author", context: :as_signed_in_user do
    let(:post) { create(:post, user: user) }

    permissions :show?, :new_text?, :new_link?, :new_image?, :create? do
      it { is_expected.to permit(user, post) }
    end

    context "text post" do
      let(:post) { create(:text_post, user: user) }

      permissions :edit?, :update? do
        it { is_expected.to permit(user, post) }
      end
    end

    context "link post" do
      let(:post) { create(:link_post, user: user) }

      permissions :edit?, :update? do
        it { is_expected.to_not permit(user, post) }
      end
    end

    context "image post" do
      let(:post) { create(:image_post, user: user) }

      permissions :edit?, :update? do
        it { is_expected.to_not permit(user, post) }
      end
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains :title, :text, :url, :image, :explicit and :spoiler attributes" do
      policy = described_class.new(nil)

      expect(policy.permitted_attributes_for_create).to contain_exactly(:title, :text, :url, :image, :explicit, :spoiler)
    end
  end

  describe ".permitted_attributes_for_update" do
    context "for author", context: :as_signed_in_user do
      it "contains :text attribute" do
        post = create(:post, user: user)
        policy = described_class.new(user, post)

        expect(policy.permitted_attributes_for_update).to contain_exactly(:text)
      end
    end
  end
end
