require "rails_helper"

RSpec.describe Follow do
  subject { described_class }

  describe "validations" do
    subject { create(:community_follow) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to([:followable_type, :followable_id]) }
  end
end
