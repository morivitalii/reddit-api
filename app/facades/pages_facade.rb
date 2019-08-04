# frozen_string_literal: true

class PagesFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("pages")}" : I18n.t("pages")
  end

  def show_meta_title
    sub_context? ? "#{sub.title}: #{record.title}" : record.title
  end

  def new_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("pages")}" : I18n.t("pages")
  end

  def edit_meta_title
    sub_context? ? "#{sub.title}: #{record.title}" : record.title
  end

  def pagination_permitted_params
    [:sub]
  end
end