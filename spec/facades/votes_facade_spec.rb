require "rails_helper"

RSpec.describe VotesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:context) { Context.new(user) }

  describe ".index_meta_title" do
    it "returns title" do
      expected_result = "#{user.username}: #{I18n.t("votes")}"
      result = subject.new(context, user).index_meta_title

      expect(result).to eq(expected_result)
    end
  end
end