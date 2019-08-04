# frozen_string_literal: true

class ModQueuesFacade < ApplicationFacade
  def index_meta_title
    sub_context? ? "#{sub.title}: #{I18n.t("mod_queue")}" : I18n.t("mod_queue")
  end

  def pagination_permitted_params
    [:sub]
  end
end