require "rails_helper"

RSpec.describe PagePolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }
  let(:global_page) { create(:global_page) }
  let(:sub_page) { create(:sub_page, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      permissions :index?, :show? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to_not permit(global_context, global_page) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_page) }
      end
    end

    context "sub" do
      permissions :index?, :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to_not permit(sub_context, sub_page) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(sub_context,sub_page) }
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "global" do
      permissions :index?, :show? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to_not permit(global_context, global_page) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_page) }
      end
    end

    context "sub" do
      permissions :index?, :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to_not permit(sub_context, sub_page) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(sub_context, sub_page) }
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    context "global" do
      permissions :index?, :show? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to_not permit(global_context, global_page) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_page) }
      end
    end

    context "sub" do
      permissions :index?, :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to permit(sub_context, sub_page) }
      end

      permissions :destroy? do
        it { is_expected.to permit(sub_context, sub_page) }
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    context "global" do
      permissions :index?, :show? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(global_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to permit(global_context, global_page) }
      end

      permissions :destroy? do
        it { is_expected.to permit(global_context, global_page) }
      end
    end

    context "sub" do
      permissions :index?, :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :edit?, :update? do
        it { is_expected.to permit(sub_context, sub_page) }
      end

      permissions :destroy? do
        it { is_expected.to permit(sub_context, sub_page) }
      end
    end
  end
end