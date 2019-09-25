# frozen_string_literal: true

class CommunityDecorator < ApplicationDecorator
  def followers_count
    followers_count_formatted = h.number_with_delimiter(model.followers_count)
    h.t("shared.sidebar.followers", count: model.followers_count, count_formatted: followers_count_formatted)
  end
end