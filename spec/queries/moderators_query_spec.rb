require "rails_helper"

RSpec.describe ModeratorsQuery do
  subject { described_class }

  describe ".recent" do
    it "returns limited recent moderators" do
      moderators = create_list(:moderator, 3)
      recent_moderators = moderators[0..1]

      result = subject.new.recent(2)

      expect(result).to eq(recent_moderators)
    end
  end
end
