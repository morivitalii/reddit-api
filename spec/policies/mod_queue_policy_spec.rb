require "rails_helper"

RSpec.describe ModQueuePolicy, type: :policy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :new_posts?, :new_comments?, :reported_posts?, :reported_comments? do
      it { is_expected.to permit(context) }
    end
  end
end