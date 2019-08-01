require "rails_helper"

RSpec.describe SubPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { UserContext.new(user, sub) }

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end

    permissions :edit?, :update? do
      it "denies access" do
        expect(subject).to_not permit(context)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { UserContext.new(user, sub) }

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end

    permissions :edit?, :update? do
      it "denies access" do
        expect(subject).to_not permit(context)
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }
    let(:context) { UserContext.new(user, sub) }

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end

    permissions :edit?, :update? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }
    let(:context) { UserContext.new(user, sub) }

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end

    permissions :edit?, :update? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end
end