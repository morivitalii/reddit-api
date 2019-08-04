# frozen_string_literal: true

class ModeratorsFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("moderators")}" : I18n.t("moderators")
  end

  def pagination_permitted_params
    [:sub]
  end
end