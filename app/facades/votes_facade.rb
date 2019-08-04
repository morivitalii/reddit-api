# frozen_string_literal: true

class VotesFacade < ApplicationFacade
  def index_meta_title
    "#{record.username}: #{I18n.t("votes")}"
  end

  def pagination_permitted_params
    []
  end
end