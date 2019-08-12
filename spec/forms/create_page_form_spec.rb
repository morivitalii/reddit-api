require "rails_helper"

RSpec.describe CreatePageForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { create(:sub) }
    let(:title) { "Title" }
    let(:text) { "Text" }

    before do
      @form = subject.new(
        sub: sub,
        title: title,
        text: text
      )
    end

    it "creates page" do
      @form.save
      result = @form.page

      expect(result).to have_attributes(sub: sub, title: title, text: text)
    end
  end
end