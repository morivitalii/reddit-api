require "rails_helper"

RSpec.describe DateTimeHelper, type: :helper do
  describe "#datetime_ago_tag" do
    it "has datetime ago in words as content" do
      datetime = Time.current

      result = helper.datetime_ago_tag(datetime)

      expect(result).to include(time_ago_in_words(datetime))
    end

    it "has class datetime-ago" do
      datetime = Time.current

      result = helper.datetime_ago_tag(datetime)

      expect(result).to include("class=\"datetime-ago\"")
    end

    it "has data attribute timestamp" do
      datetime = Time.current

      result = helper.datetime_ago_tag(datetime)

      expect(result).to include("data-timestamp=\"#{datetime.to_i}\"")
    end
  end

  describe "#datetime_short_tag" do
    it "has localized datetime in short form as content" do
      datetime = Time.current

      result = helper.datetime_short_tag(datetime)

      expect(result).to include(I18n.l(datetime, format: :short))
    end

    it "has class datetime-short" do
      datetime = Time.current

      result = helper.datetime_short_tag(datetime)

      expect(result).to include("class=\"datetime-short\"")
    end

    it "has data attribute timestamp" do
      datetime = Time.current

      result = helper.datetime_short_tag(datetime)

      expect(result).to include("data-timestamp=\"#{datetime.to_i}\"")
    end
  end
end