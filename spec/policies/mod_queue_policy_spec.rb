require "rails_helper"

RSpec.describe ModQueuePolicy, type: :policy do
  subject { described_class }

  context "for visitor" do
    include_context "visitor context"
    
    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user" do
    include_context "user context"

    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator" do
    include_context "moderator context"

    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to permit(context) }
    end
  end
end