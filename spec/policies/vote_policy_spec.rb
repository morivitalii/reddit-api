require "rails_helper"

RSpec.describe VotePolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :posts?, :comments?, :create?, :destroy? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :posts?, :comments?, :create?, :destroy? do
      it { is_expected.to permit(context) }
    end
  end
end