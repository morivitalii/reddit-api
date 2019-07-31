require "rails_helper"

RSpec.describe RulePolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:rule_class) { Rule }
  let(:global_rule) { create(:global_rule) }
  let(:sub_rule) { create(:sub_rule, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_rule)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_rule)
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
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_rule)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_rule)
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
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_rule)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_rule)
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
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, global_rule)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, rule_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_rule)
        end
      end
    end
  end
end