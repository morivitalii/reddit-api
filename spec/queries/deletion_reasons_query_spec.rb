require "rails_helper"

RSpec.describe DeletionReasonsQuery do
  subject { described_class.new }

  describe ".where_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_deletion_reasons) { [create(:sub_deletion_reason, sub: sub)] }
    let!(:global_deletion_reasons) { [create(:global_deletion_reason)] }

    it "returns sub deletion reasons" do
      expected_result = sub_deletion_reasons
      result = subject.where_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global" do
    let!(:deletion_reasons) { [create(:global_deletion_reason)] }

    it "returns global deletion reasons" do
      expected_result = deletion_reasons
      result = subject.where_global.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_global_or_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_deletion_reasons) { [create(:sub_deletion_reason, sub: sub)] }
    let!(:global_deletion_reasons) { [create(:global_deletion_reason)] }

    it "returns global and sub deletion reasons" do
      expected_result = sub_deletion_reasons + global_deletion_reasons
      result = subject.where_global_or_sub(sub)

      expect(result).to eq(expected_result)
    end
  end
end