# frozen_string_literal: true

class RulesFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("rules")}" : I18n.t("rules")
  end

  def pagination_permitted_params
    [:sub]
  end
end