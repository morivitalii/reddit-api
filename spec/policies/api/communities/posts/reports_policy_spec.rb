require "rails_helper"

RSpec.describe Api::Communities::Posts::ReportsPolicy do
  subject { described_class }

  context "as signed out user", context: :as_signed_out_user do
    let(:post) { create(:post) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as signed in user", context: :as_signed_in_user do
    let(:post) { create(:post) }

    permissions :index? do
      it { is_expected.to_not permit(context, post) }
    end

    permissions :create? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as admin user", context: :as_admin_user do
    let(:post) { create(:post) }

    permissions :index?, :create? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as moderator user", context: :as_moderator_user do
    let(:post) { create(:post, community: context.community) }

    permissions :index?, :create? do
      it { is_expected.to permit(context, post) }
    end
  end

  context "as muted user", context: :as_muted_user do
    let(:post) { create(:post, community: context.community) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  context "as banned user", context: :as_banned_user do
    let(:post) { create(:post, community: context.community) }

    permissions :index?, :create? do
      it { is_expected.to_not permit(context, post) }
    end
  end

  describe ".permitted_attributes_for_create" do
    it "contains attributes" do
      policy = described_class.new(Context.new(nil, nil))

      expect(policy.permitted_attributes_for_create).to contain_exactly(:text)
    end
  end
end
