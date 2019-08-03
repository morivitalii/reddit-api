require "rails_helper"

RSpec.describe SubsQuery do
  subject { described_class.new }

  describe ".where_url" do
    let!(:subs) { create_pair(:sub) }

    it "returns sub with given url" do
      expected_result = [subs.first]
      url = expected_result.first.url
      result = subject.where_url(url).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".default" do
    let!(:subs) { [create(:sub)] }
    let!(:default_sub) { [create(:sub, url: "all")] }

    it "return default sub" do
      expected_result = default_sub
      result = subject.default.all

      expect(result).to eq(expected_result)
    end
  end
end