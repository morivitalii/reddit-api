require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { Context.new(user) }

    permissions :show?, :comments? do
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
    let(:context) { Context.new(user) }

    permissions :show?, :comments? do
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