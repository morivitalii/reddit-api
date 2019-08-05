require "rails_helper"

RSpec.describe ModeratorPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }
  let(:global_moderator) { create(:global_moderator) }
  let(:sub_moderator) { create(:sub_moderator, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      permissions :index? do
        it { is_expected.to permit(global_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(global_context) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_moderator) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(sub_context, sub_moderator) }
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

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_moderator) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :destroy? do
        it { is_expected.to_not permit(sub_context, sub_moderator) }
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

      permissions :destroy? do
        it { is_expected.to_not permit(global_context, global_moderator) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :destroy? do
        it { is_expected.to permit(sub_context, sub_moderator) }
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

      permissions :destroy? do
        it { is_expected.to permit(global_context, global_moderator) }
      end
    end

    context "sub" do
      permissions :index? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :destroy? do
        it { is_expected.to permit(sub_context, sub_moderator) }
      end
    end
  end
end