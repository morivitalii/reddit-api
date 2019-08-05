require "rails_helper"

RSpec.describe BanPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }
  let(:global_ban) { create(:global_ban) }
  let(:sub_ban) { create(:sub_ban, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      permissions :index? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to_not permit(global_context, global_ban) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context)  }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to_not permit(sub_context, sub_ban)  }
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "global" do
      permissions :index? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to_not permit(global_context, global_ban) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to_not permit(sub_context, sub_ban) }
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    context "global" do
      permissions :index? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to_not permit(global_context, global_ban) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to permit(sub_context, sub_ban) }
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    context "global" do
      permissions :index? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(global_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to permit(global_context, global_ban) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :edit?, :update?, :destroy? do
        it { is_expected.to permit(sub_context, sub_ban) }
      end
    end
  end
end