require "rails_helper"

RSpec.describe Communities::ModQueues::New::PostsPolicy do
  subject { described_class }

  context "for visitor", context: :visitor do
    permissions :index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for user", context: :user do
    permissions :index? do
      it { is_expected.to_not permit(context) }
    end
  end

  context "for moderator", context: :moderator do
    permissions :index? do
      it { is_expected.to permit(context) }
    end
  end
end
