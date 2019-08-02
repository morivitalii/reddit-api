require "rails_helper"

RSpec.describe BanPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:ban_class) { Ban }
  let(:global_ban) { create(:global_ban) }
  let(:sub_ban) { create(:sub_ban, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_ban)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_ban)
        end
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_ban)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_ban)
        end
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_ban)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_ban)
        end
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, global_ban)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, ban_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_ban)
        end
      end
    end
  end
end