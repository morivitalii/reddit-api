# frozen_string_literal: true

class DeletionReasonsFacade < ApplicationFacade
  def index_meta_title
    "#{sub.title}: #{I18n.t("deletion_reasons")}"
  end
end