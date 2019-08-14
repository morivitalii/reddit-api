# frozen_string_literal: true

class ReportsFacade < ApplicationFacade
  def posts_meta_title
    "#{community.title}: #{I18n.t("posts_reports")}"
  end

  def comments_meta_title
    "#{community.title}: #{I18n.t("comments_reports")}"
  end
end