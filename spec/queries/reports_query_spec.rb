require "rails_helper"

RSpec.describe ReportsQuery do
  subject { described_class }

  describe ".recent" do
    it "returns limited recent reports" do
      reports = create_list(:report, 3)
      recent_reports = reports[1..-1].reverse

      result = subject.new.recent(2)

      expect(result).to eq(recent_reports)
    end
  end
end
