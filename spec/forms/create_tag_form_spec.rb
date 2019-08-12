require "rails_helper"

RSpec.describe CreateTagForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { create(:sub) }
    let(:title) { "Title" }

    before do
      @form = subject.new(
        sub: sub,
        title: title
      )
    end

    it "creates tag" do
      @form.save
      result = @form.tag

      expect(result).to have_attributes(sub: sub, title: title)
    end
  end
end