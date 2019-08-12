# frozen_string_literal: true

class ModQueuesFacade < ApplicationFacade
  def posts_meta_title
    "#{sub.title}: #{I18n.t("posts_mod_queue")}"
  end

  def comments_meta_title
    "#{sub.title}: #{I18n.t("comments_mod_queue")}"
  end
end