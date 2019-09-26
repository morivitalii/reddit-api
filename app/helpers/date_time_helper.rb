# frozen_string_literal: true

module DateTimeHelper
  def datetime_ago_tag(datetime)
    content_tag("span", time_ago_in_words(datetime), class: "datetime-ago", data: {timestamp: datetime.to_i})
  end

  def datetime_short_tag(datetime)
    content_tag("span", l(datetime, format: :short), class: "datetime-short", data: {timestamp: datetime.to_i})
  end
end
