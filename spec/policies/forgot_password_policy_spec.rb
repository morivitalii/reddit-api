require "rails_helper"

RSpec.describe ForgotPasswordPolicy do
  subject { described_class }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { UserContext.new(user) }

    permissions :new?, :create? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { UserContext.new(user) }

    permissions :new?, :create? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end
end