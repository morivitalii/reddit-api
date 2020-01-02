require "rails_helper"

RSpec.describe Community do
  subject { described_class }

  it_behaves_like "paginatable"

  describe "validations" do
    subject { create(:community) }

    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url).case_insensitive }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(30) }
    it { is_expected.to validate_length_of(:description).is_at_most(200) }
  end

  describe ".to_param" do
    it "returns :url attribute" do
      community = build(:community)

      expect(community.to_param).to eq(community.url)
    end
  end
end
