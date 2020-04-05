require "rails_helper"

RSpec.describe ModeratorsQuery do
  subject { described_class }

  describe ".with_username" do
    it "returns moderators where user has given username" do
      user = create(:user)
      moderators = create_pair(:moderator, user: user)
      create_pair(:moderator)

      result = subject.new.with_username(user.username)

      expect(result).to match_array(moderators)
    end
  end

  describe ".recent" do
    it "returns limited recent moderators" do
      moderators = create_list(:moderator, 3)
      recent_moderators = moderators[0..1]

      result = subject.new.recent(2)

      expect(result).to eq(recent_moderators)
    end
  end
end
