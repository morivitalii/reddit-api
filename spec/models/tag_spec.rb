require "rails_helper"

RSpec.describe Tag do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :title, squish: true

  describe "uniqueness validation" do
    it "adds error on title attribute if given value is not unique" do
      tag = create(:tag)
      model = subject.new(title: tag.title)
      model.validate

      expected_result = { error: :taken }
      result = model.errors.details[:title]

      expect(result).to include(expected_result)
    end

    it "is valid if given value is unique" do
      model = subject.new(title: "tag")
      model.validate

      expected_result = { error: :taken }
      result = model.errors.details[:title]

      expect(result).to_not include(expected_result)
    end
  end

  describe "limits validation on create" do
    it "adds error on title attribute if out of limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT)
      model.validate

      expected_result = { error: :tags_limit }
      result = model.errors.details[:title]

      expect(result).to include(expected_result)
    end

    it "is valid if within limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT - 1)
      model.validate

      expected_result = { error: :tags_limit }
      result = model.errors.details[:title]

      expect(result).to_not include(expected_result)
    end
  end
end