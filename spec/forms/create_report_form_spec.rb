require "rails_helper"

RSpec.describe CreateReportForm, type: :form do
  subject { described_class }

  describe ".save" do
    let(:user) { create(:user) }
    let(:reportable) { create(:post) }
    let(:text) { "Text" }

    before do
      @form = subject.new(
        reportable: reportable,
        user: user,
        text: text
      )
    end

    it "returns true if reportable.ignore_reports? is true" do
      allow(@form).to receive(:skip?).and_return(true)

      expected_result = true
      result = @form.save

      expect(result).to eq(expected_result)
    end

    it "does not create report if one from user to reportable already exists" do
      create(:report, reportable: reportable, user: user)

      expect { @form.save }.to_not change { Report.count }
    end

    it "returns report if already exists" do
      expected_result = create(:report, reportable: reportable, user: user)
      result = @form.save

      expect(result).to eq(expected_result)
    end

    it "creates report" do
      expected_attributes = { reportable: reportable, user: user, community: reportable.community, text: text }
      result = @form.save

      expect(result).to have_attributes(expected_attributes)
    end
  end
end