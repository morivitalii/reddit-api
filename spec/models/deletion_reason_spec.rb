require "rails_helper"

RSpec.describe DeletionReason do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :title, :description, squish: true

  describe "limits validation on create" do
    it "adds error on title attribute if out of limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT)
      model.validate

      expect(model).to have_error(:deletion_reasons_limit).on(:title)
    end

    it "is valid if within limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT - 1)
      model.validate

      expect(model).to_not have_error(:deletion_reasons_limit).on(:title)
    end
  end
end