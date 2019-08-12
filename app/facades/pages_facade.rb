# frozen_string_literal: true

class PagesFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("pages")}"
  end

  def show_meta_title
    "#{sub.title}: #{record.title}"
  end

  def new_meta_title
    "#{sub.title}: #{I18n.t("pages")}"
  end

  def edit_meta_title
    "#{sub.title}: #{record.title}"
  end
end