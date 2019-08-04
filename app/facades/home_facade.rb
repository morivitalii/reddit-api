# frozen_string_literal: true

class HomeFacade < ApplicationFacade
  def index_meta_title
    I18n.t("app_name")
  end

  def pagination_permitted_params
    # TODO
    []
  end
end