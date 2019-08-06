require "rails_helper"

RSpec.describe CreateDeletionReasonForm do
  subject { described_class.new(title: title, description: description) }

  let(:title) { "Title" }
  let(:description) { "Description" }

  describe ".save" do
    it "creates deletion reason" do
      subject.save
      result = subject.deletion_reason

      expect(result).to have_attributes(title: title, description: description)
    end
  end
end