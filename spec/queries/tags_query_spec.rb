require "rails_helper"

RSpec.describe TagsQuery do
  subject { described_class }

  describe ".with_title" do
    let!(:expected) { create(:tag) }
    let!(:others) { create_pair(:tag) }

    it "returns results filtered by title" do
      result = subject.new.with_title(expected.title).take

      expect(result).to eq(expected)
    end
  end
end