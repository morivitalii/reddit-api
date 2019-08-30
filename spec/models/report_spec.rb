require "rails_helper"

RSpec.describe Report do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "validations" do
    subject { build(:report) }

    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(500) }
  end
end