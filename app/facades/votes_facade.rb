# frozen_string_literal: true

class VotesFacade < ApplicationFacade
  def posts_meta_title
    "#{record.username}: #{I18n.t("posts_votes")}"
  end

  def comments_meta_title
    "#{record.username}: #{I18n.t("comments_votes")}"
  end
end