require "rails_helper"

RSpec.describe PagesQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:pages) { [create(:sub_page, sub: sub)] }

    it "returns sub pages" do
      expected_result = pages
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:pages) { [create(:global_page)] }

    it "returns global pages" do
      expected_result = pages
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end
end