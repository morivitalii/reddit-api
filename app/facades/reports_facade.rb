# frozen_string_literal: true

class ReportsFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("reports")}" : I18n.t("reports")
  end

  def pagination_permitted_params
    [:sub]
  end
end