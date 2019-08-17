require "rails_helper"

RSpec.describe SignInPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :new?, :create? do
      it { is_expected.to_not permit(context) }
    end
  end
end