require "rails_helper"

RSpec.describe CreateReportForm do
  it { expect(described_class.new).to_not be_persisted }

  shared_examples "ignore reports" do
    context "and ignores reports" do
      it "returns true" do
        form = build_create_report_form(reportable)
        allow(reportable).to receive(:ignore_reports?).and_return(true)

        result = form.save

        expect(result).to be_truthy
      end

      it "does not create report" do
        form = build_create_report_form(reportable)
        allow(reportable).to receive(:ignore_reports?).and_return(true)

        expect { form.save }.to_not change { Report.count }
      end
    end
  end

  shared_examples "does not ignore reports" do
    context "and does not ignore reports" do
      it "returns true" do
        form = build_create_report_form(reportable)
        allow(reportable).to receive(:ignore_reports?).and_return(false)

        result = form.save

        expect(result).to be_truthy
      end

      it "creates report" do
        form = build_create_report_form(reportable)
        allow(reportable).to receive(:ignore_reports?).and_return(false)

        expect { form.save }.to change { Report.count }
      end
    end
  end

  describe ".save" do
    context "when reportable is post" do
      let(:reportable) { create(:post) }

      include_examples "ignore reports"
      include_examples "does not ignore reports"
    end

    context "when reportable is comment" do
      let(:reportable) { create(:comment) }

      include_examples "ignore reports"
      include_examples "does not ignore reports"
    end
  end

  def build_create_report_form(reportable)
    user = create(:user)

    described_class.new(
      reportable: reportable,
      user: user,
      text: "Report"
    )
  end
end