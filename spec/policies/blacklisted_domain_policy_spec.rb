require "rails_helper"

RSpec.describe BlacklistedDomainPolicy do
  subject { described_class }

  let(:sub) { create(:sub) }
  let(:blacklisted_domain_class) { BlacklistedDomain }
  let(:global_blacklisted_domain) { create(:global_blacklisted_domain) }
  let(:sub_blacklisted_domain) { create(:sub_blacklisted_domain, sub: sub) }

  context "for visitor" do
    let(:user) { nil }

    context "global" do
      let(:context) { UserContext.new(user) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_blacklisted_domain)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_blacklisted_domain)
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
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_blacklisted_domain)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, sub_blacklisted_domain)
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
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "denies access" do
          expect(subject).to_not permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "denies access" do
          expect(subject).to_not permit(context, global_blacklisted_domain)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_blacklisted_domain)
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
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, global_blacklisted_domain)
        end
      end
    end

    context "sub" do
      let(:context) { UserContext.new(user, sub) }

      permissions :index? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(context, blacklisted_domain_class)
        end
      end

      permissions :destroy? do
        it "grants access" do
          expect(subject).to permit(context, sub_blacklisted_domain)
        end
      end
    end
  end
end