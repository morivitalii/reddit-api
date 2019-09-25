# frozen_string_literal: true

class BanDecorator < ApplicationDecorator
  def username
    model.user.username
  end

  def details
    created_at = h.t("bans.ban.created_at_html", created_at: h.datetime_short_tag(model.created_at))
    type = model.permanent? ? h.t("bans.ban.permanent") : h.t("bans.ban.end_at_html", end_at: h.datetime_short_tag(model.end_at))
    reason = model.reason.present? ? h.t("bans.ban.reason", reason: ban.reason) : ""

    h.content_tag(:span) do
      h.concat(created_at)
      h.concat " "
      h.concat(type)
      h.concat " "
      h.concat(reason)
    end
  end
end