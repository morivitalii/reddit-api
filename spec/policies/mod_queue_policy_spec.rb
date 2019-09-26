require "rails_helper"

RSpec.describe ModQueuePolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :new_posts_index?, :new_comments_index?, :reported_posts_index?, :reported_comments_index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :new_posts_index?, :new_comments_index?, :reported_posts_index?, :reported_comments_index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :new_posts_index?, :new_comments_index?, :reported_posts_index?, :reported_comments_index? do
      it { is_expected.to permit(context) }
    end
  end
end
