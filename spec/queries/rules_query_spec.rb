require "rails_helper"

RSpec.describe RulesQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_rules) { [create(:sub_rule, sub: sub)] }
    let!(:global_rules) { [create(:global_rule)] }

    it "returns sub rules" do
      expected_result = sub_rules
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:sub_rules) { [create(:sub_rule)] }
    let!(:global_rules) { [create(:global_rule)] }

    it "returns global rules" do
      expected_result = global_rules
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end
end