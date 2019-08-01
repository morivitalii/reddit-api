require "rails_helper"

RSpec.describe ModQueuePolicy do
  subject { described_class }

  let(:sub) { create(:sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index?, :comments? do
        it "denies access" do
          expect(subject).to_not permit(context)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index?, :comments? do
        it "denies access" do
          expect(subject).to_not permit(context)
        end
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index?, :comments? do
        it "denies access" do
          expect(subject).to_not permit(context)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index?, :comments? do
        it "denies access" do
          expect(subject).to_not permit(context)
        end
      end
    end
  end

  context "for sub moderator" do
    let(:user) { create(:sub_moderator, sub: sub).user }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index?, :comments? do
        it "grants access" do
          expect(subject).to permit(context)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index?, :comments? do
        it "grants access" do
          expect(subject).to permit(context)
        end
      end
    end
  end

  context "for global moderator" do
    let(:user) { create(:global_moderator).user }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index?, :comments? do
        it "grants access" do
          expect(subject).to permit(context)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index?, :comments? do
        it "grants access" do
          expect(subject).to permit(context)
        end
      end
    end
  end
end