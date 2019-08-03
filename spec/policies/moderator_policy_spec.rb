require "rails_helper"

RSpec.describe ModeratorPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:moderator_class) { Moderator }
  let(:global_moderator) { create(:global_moderator) }
  let(:sub_moderator) { create(:sub_moderator, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_moderator)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_moderator)
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
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_moderator)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_moderator)
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
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_moderator)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_moderator)
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
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, global_moderator)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, moderator_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_moderator)
        end
      end
    end
  end
end