# frozen_string_literal: true

class UsersFacade < ApplicationFacade
  def posts_meta_title
    "#{record.username}: #{I18n.t("posts")}"
  end

  def comments_meta_title
    "#{record.username}: #{I18n.t("comments")}"
  end

  def edit_meta_title
    "#{record.username}: #{I18n.t("settings")}"
  end

  def pagination_params
    # TODO
    []
  end
end