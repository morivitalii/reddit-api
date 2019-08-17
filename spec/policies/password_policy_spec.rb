require "rails_helper"

RSpec.describe PasswordPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"

    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :edit?, :update? do
      it { is_expected.to permit(context) }
    end
  end
end