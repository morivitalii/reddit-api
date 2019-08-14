# frozen_string_literal: true

class RulesFacade < ApplicationFacade
  def index_meta_title
    "#{community.title}: #{I18n.t("rules")}"
  end
end