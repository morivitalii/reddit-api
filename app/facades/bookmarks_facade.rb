# frozen_string_literal: true

class BookmarksFacade < ApplicationFacade
  def index_meta_title
    "#{record.username}: #{I18n.t("bookmarks")}"
  end

  def pagination_permitted_params
    []
  end
end