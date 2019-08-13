require "rails_helper"

RSpec.describe Tag do
  subject { described_class }

  it_behaves_like "paginatable"
  it_behaves_like "strip attributes", :title, squish: true

  describe "uniqueness validation" do
    it "adds error on title attribute if given value is not unique" do
      sub = create(:sub)
      tag = create(:tag, sub: sub)
      model = subject.new(sub: sub, title: tag.title)
      model.validate

      expect(model).to have_error(:taken).on(:title)
    end

    it "is valid if given value is unique" do
      sub = create(:sub)
      model = subject.new(sub: sub, title: "tag")
      model.validate

      expect(model).to_not have_error(:taken).on(:title)
    end
  end

  describe "limits validation on create" do
    it "adds error on title attribute if out of limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT)
      model.validate

      expect(model).to have_error(:tags_limit).on(:title)
    end

    it "is valid if within limit" do
      model = subject.new
      allow(model).to receive(:existent_count).and_return(described_class::LIMIT - 1)
      model.validate

      expect(model).to_not have_error(:tags_limit).on(:title)
    end
  end
end