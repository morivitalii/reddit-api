# frozen_string_literal: true

class BlacklistedDomainsFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("blacklisted_domains")}"
  end
end