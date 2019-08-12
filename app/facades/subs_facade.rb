# frozen_string_literal: true

class SubsFacade < ApplicationFacade
  def show_meta_title
    sub.title
  end

  def edit_meta_title
    "#{sub.title}: #{I18n.t("settings")}"
  end

  def pagination_params
    # TODO
    []
  end
end