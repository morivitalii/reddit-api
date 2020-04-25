require "rails_helper"

RSpec.describe Tag do
  subject { described_class }

  describe "validations" do
    subject { build(:tag) }

    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:text).scoped_to(:community_id).case_insensitive }
  end
end
