# frozen_string_literal: true

class BansFacade < ApplicationFacade
  def index_meta_title
    "#{community.title}: #{I18n.t("bans")}"
  end
end