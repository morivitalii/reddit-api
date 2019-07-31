require "rails_helper"

RSpec.describe FollowPolicy do
  subject { described_class }

  let(:follow_class) { Follow }
  let(:sub) { create(:sub) }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { UserContext.new(user, sub) }

    permissions :create?, :destroy? do
      it "denies access" do
        expect(subject).to_not permit(context, follow_class)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { UserContext.new(user, sub) }

    context "follower" do
      before { create(:follow, user: user, sub: sub) }

      permissions :create? do
        it "denies access" do
          expect(subject).to_not permit(context, follow_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, follow_class)
        end
      end
    end

    context "not follower" do
      permissions :create? do
        it "grants access" do
          expect(subject).to permit(context, follow_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, follow_class)
        end
      end
    end
  end
end