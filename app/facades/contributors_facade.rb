# frozen_string_literal: true

class ContributorsFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("contributors")}"
  end
end