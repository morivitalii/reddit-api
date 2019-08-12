# frozen_string_literal: true

class RulesFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("rules")}"
  end
end