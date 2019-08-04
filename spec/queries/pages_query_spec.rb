require "rails_helper"

RSpec.describe PagesQuery do
  subject { described_class.new }

  describe ".sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_pages) { [create(:sub_page, sub: sub)] }
    let!(:global_pages) { [create(:global_page)] }

    it "returns sub pages" do
      expected_result = sub_pages
      result = subject.sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".global" do
    let!(:sub_pages) { [create(:sub_page)] }
    let!(:global_pages) { [create(:global_page)] }

    it "returns global pages" do
      expected_result = global_pages
      result = subject.global.all

      expect(result).to eq(expected_result)
    end
  end
end