require "rails_helper"

RSpec.describe VotesFacade do
  subject { described_class.new(context, user) }

  let(:user) { create(:user) }
  let(:context) { Context.new(user) }

  describe ".index_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("votes")}"
      result = subject.index_meta_title

      expect(result).to eq(expected_result)
    end
  end
end