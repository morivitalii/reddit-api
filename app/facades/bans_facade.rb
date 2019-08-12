# frozen_string_literal: true

class BansFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("bans")}"
  end
end