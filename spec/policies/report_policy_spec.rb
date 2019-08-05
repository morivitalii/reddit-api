require "rails_helper"

RSpec.describe ReportPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      permissions :index?, :comments? do
        it { is_expected.to_not permit(global_context) }
      end
    end

    context "sub" do
      permissions :index?, :comments? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :show? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to_not permit(sub_context) }
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "global" do
      permissions :index?, :comments? do
        it { is_expected.to_not permit(global_context) }
      end
    end

    context "sub" do
      permissions :index?, :comments? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :show? do
        it { is_expected.to_not permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    context "global" do
      permissions :index?, :comments? do
        it { is_expected.to permit(global_context) }
      end
    end

    context "sub" do
      permissions :index?, :comments? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    context "global" do
      permissions :index?, :comments? do
        it { is_expected.to permit(global_context) }
      end
    end

    context "sub" do
      permissions :index?, :comments? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :show? do
        it { is_expected.to permit(sub_context) }
      end

      permissions :new?, :create? do
        it { is_expected.to permit(sub_context) }
      end
    end
  end
end