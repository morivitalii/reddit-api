# frozen_string_literal: true

class TagsFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("tags")}"
  end
end