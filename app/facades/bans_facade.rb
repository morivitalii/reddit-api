# frozen_string_literal: true

class BansFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("bans")}" : I18n.t("bans")
  end

  def pagination_permitted_params
    [:sub]
  end
end