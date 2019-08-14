require "rails_helper"

RSpec.describe VotePolicy do
  subject { described_class }

  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  context "for visitor" do
    let(:user) { nil }

    permissions :posts?, :comments?, :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    let(:user) { create(:user) }

    permissions :posts?, :comments?, :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end