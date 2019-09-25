require "rails_helper"

RSpec.describe Moderator do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "validations" do
    subject { create(:moderator) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:community_id) }
  end
end