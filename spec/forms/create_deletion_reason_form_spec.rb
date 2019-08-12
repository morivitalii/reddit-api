require "rails_helper"

RSpec.describe CreateDeletionReasonForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { create(:sub) }
    let(:title) { "Title" }
    let(:description) { "Description" }

    before do
      @form = subject.new(
        sub: sub,
        title: title,
        description: description
      )
    end

    it "creates deletion reason" do
      @form.save
      result = @form.deletion_reason

      expect(result).to have_attributes(sub: sub, title: title, description: description)
    end
  end
end