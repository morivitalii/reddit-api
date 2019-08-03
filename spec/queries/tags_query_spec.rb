require "rails_helper"

RSpec.describe TagsQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_tags) { [create(:sub_tag, sub: sub)] }
    let!(:global_tags) { [create(:global_tag)] }

    it "returns sub tags" do
      expected_result = sub_tags
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:sub_tags) { [create(:sub_tag)] }
    let!(:global_tags) { [create(:global_tag)] }

    it "returns global tags" do
      expected_result = global_tags
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global_or_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_tags) { [create(:sub_tag, sub: sub)] }
    let!(:global_tags) { [create(:global_tag)] }

    it "returns global and sub tags" do
      expected_result = sub_tags + global_tags
      result = subject.where_global_or_sub(sub)

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_title" do
    let!(:tags) { create_pair(:tag) }

    it "returns tag with given title" do
      expected_result = [tags.first]
      title = expected_result.first.title
      result = subject.filter_by_title(title).all

      expect(result).to eq(expected_result)
    end
  end
end