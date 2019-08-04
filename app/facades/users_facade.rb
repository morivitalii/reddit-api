# frozen_string_literal: true

class UsersFacade < ApplicationFacade
  def show_meta_title
    record.username
  end

  def edit_meta_title
    "#{record.username}: #{I18n.t("settings")}"
  end

  def pagination_permitted_params
    # TODO
    []
  end
end