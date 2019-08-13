require "rails_helper"

RSpec.describe ReportsQuery do
  subject { described_class }

  describe ".recent" do
    let!(:reports) { create_list(:report, 3) }

    it "returns recent reports" do
      expected_result = reports[1..-1].reverse
      result = subject.new.recent(2)

      expect(result).to eq(expected_result)
    end
  end
end