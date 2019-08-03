require "rails_helper"

RSpec.describe RulesQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:rules) { [create(:sub_rule, sub: sub)] }

    it "returns sub rules" do
      expected_result = rules
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:rules) { [create(:global_rule)] }

    it "returns global rules" do
      expected_result = rules
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end
end