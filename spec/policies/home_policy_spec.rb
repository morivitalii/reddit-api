require "rails_helper"

RSpec.describe HomePolicy do
  subject { described_class }

  context "for visitor" do
    let(:user) { nil }
    let(:context) { Context.new(user) }

    permissions :index? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end

  context "for user" do
    let(:user) { create(:user) }
    let(:context) { Context.new(user) }

    permissions :index? do
      it "grants access" do
        expect(subject).to permit(context)
      end
    end
  end
end