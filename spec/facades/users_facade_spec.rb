require "rails_helper"

RSpec.describe UsersFacade do
  subject { described_class.new(context) }

  let(:user) { create(:user) }
  let(:context) { Context.new(user) }

  describe ".show_meta_title" do
    it "returns title" do
      expected_result = user.username
      result = subject.show_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".edit_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("settings")}"
      result = subject.edit_meta_title

      expect(result).to eq(expected_result)
    end
  end
end