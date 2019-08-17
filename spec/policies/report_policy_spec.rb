require "rails_helper"

RSpec.describe ReportPolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"
    
    permissions :posts?, :comments?, :new?, :create? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :posts?, :comments? do
      it { is_expected.to_not permit(context) }
    end

    permissions :show? do
      it { is_expected.to_not permit(context) }
    end

    permissions :new?, :create? do
      it { is_expected.to permit(context) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :posts?, :comments?, :new?, :create? do
      it { is_expected.to permit(context) }
    end

    permissions :show? do
      it { is_expected.to permit(context) }
    end
  end
end