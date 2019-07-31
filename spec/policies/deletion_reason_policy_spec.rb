require "rails_helper"

RSpec.describe DeletionReasonPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:deletion_reason_class) { DeletionReason }
  let(:global_deletion_reason) { create(:global_deletion_reason) }
  let(:sub_deletion_reason) { create(:sub_deletion_reason, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(described_class).to_not permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(described_class).to_not permit(context, global_deletion_reason)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(described_class).to_not permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(described_class).to_not permit(context, sub_deletion_reason)
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
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(described_class).to_not permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(described_class).to_not permit(context, global_deletion_reason)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(described_class).to_not permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(described_class).to_not permit(context, sub_deletion_reason)
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
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(described_class).to_not permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "denies access" do
          expect(described_class).to_not permit(context, global_deletion_reason)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(described_class).to permit(context, sub_deletion_reason)
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
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(described_class).to permit(context, global_deletion_reason)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(described_class).to permit(context, deletion_reason_class)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "grants access" do
          expect(described_class).to permit(context, sub_deletion_reason)
        end
      end
    end
  end
end