require "rails_helper"

RSpec.describe BookmarkPolicy do
  subject { described_class }

  let(:context) { Context.new(user) }

  context "for visitor" do
    let(:user) { nil }

    permissions :index?, :comments? do
      it { is_expected.to_not permit(context) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :index?, :comments? do
      it { is_expected.to permit(context) }
    end

    permissions :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end