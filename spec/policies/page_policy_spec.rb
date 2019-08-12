require "rails_helper"

RSpec.describe PagePolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }
  let(:page) { create(:page, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    permissions :index?, :show? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context, page) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :index?, :show? do
      it { is_expected.to permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(context, page) }
    end
  end

  context "for moderator" do
    let(:user) { create(:moderator, sub: sub).user }
    
    permissions :index?, :show?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(context, page) }
    end
  end
end