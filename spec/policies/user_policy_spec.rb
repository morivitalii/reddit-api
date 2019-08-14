require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  context "for visitor" do
    let(:user) { nil }

    permissions :posts?, :comments? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :posts?, :comments?, :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end