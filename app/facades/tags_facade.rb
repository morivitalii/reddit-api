# frozen_string_literal: true

class TagsFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("tags")}" : I18n.t("tags")
  end

  def pagination_permitted_params
    [:sub]
  end
end