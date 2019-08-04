# frozen_string_literal: true

class ContributorsFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("contributors")}" : I18n.t("contributors")
  end

  def pagination_permitted_params
    [:sub]
  end
end