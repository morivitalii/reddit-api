require "rails_helper"

RSpec.describe DeletionReason do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :title, :description, squish: true

  describe "limits validation on create" do
    let(:expected_result) { { error: :deletion_reasons_limit } }

    it "adds error on title attribute if out of limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT)
      model.validate

      result = model.errors.details[:title]

      expect(result).to include(expected_result)
    end

    it "is valid if within limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT - 1)
      model.validate

      result = model.errors.details[:title]

      expect(result).to_not include(expected_result)
    end
  end
end