require "rails_helper"

RSpec.describe UpdatePageForm do
  subject { described_class }

  let(:page) { double(:page, update!: "", edit: "") }
  let(:edited_by_user) { double(:user) }

  describe ".save" do
    before do
      @form = subject.new(
        page: page,
        edited_by: edited_by_user
      )
    end

    it "calls .edit on page" do
      @form.save

      expect(page).to have_received(:edit).with(edited_by_user).once
    end

    it "calls .update! on page" do
      @form.save

      expect(page).to have_received(:update!).with(any_args).once
    end
  end
end