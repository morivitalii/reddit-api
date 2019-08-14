# frozen_string_literal: true

class ModeratorsFacade < ApplicationFacade
  def index_meta_title
    "#{community.title}: #{I18n.t("moderators")}"
  end
end