require "rails_helper"

RSpec.shared_examples_for "reportable" do
  before do
    @model = create(described_class.to_s.underscore.to_sym)
  end

  describe ".delete_reports", if: @model.respond_to?(:approvable?) || @model.respond_to?(:removable?) do
    let!(:report) { create(:report, reportable: model) }

    it "delete reports on approving" do
      expect { @model.save! }.to change { Report.count }.by(-1)
    end

    it "delete reports on removing" do
      expect { @model.save! }.to change { Report.count }.by(-1)
    end
  end

  describe ".reportable?" do
    it { is_expected.to be_truthy }
  end
end