# frozen_string_literal: true

class CommunitiesFacade < ApplicationFacade
  def show_meta_title
    community.title
  end

  def edit_meta_title
    "#{community.title}: #{I18n.t("settings")}"
  end
end