# frozen_string_literal: true

class ModeratorsFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("moderators")}"
  end
end