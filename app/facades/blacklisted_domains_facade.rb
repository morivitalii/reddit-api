# frozen_string_literal: true

class BlacklistedDomainsFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("blacklisted_domains")}" : I18n.t("blacklisted_domains")
  end

  def pagination_permitted_params
    [:sub]
  end
end