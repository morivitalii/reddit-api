require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :posts?, :comments? do
      it { is_expected.to permit(context) }
    end

    permissions :edit?, :update? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :posts?, :comments?, :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end