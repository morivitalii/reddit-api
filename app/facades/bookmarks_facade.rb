# frozen_string_literal: true

class BookmarksFacade < ApplicationFacade
  def posts_meta_title
    "#{record.username}: #{I18n.t("posts_bookmarks")}"
  end

  def comments_meta_title
    "#{record.username}: #{I18n.t("comments_bookmarks")}"
  end

  def pagination_params
    # TODO
    []
  end
end