# frozen_string_literal: true

module RemovableDecorator
  extend ActiveSupport::Concern

  included do
    def remove_link
      removed = model.removed?

      link_icon = h.fa_icon("trash")
      link_path = [:remove, model]
      link_class = removed ? "remove text-danger" : "remove"

      h.link_to(link_icon, link_path, remote: true, class: link_class, data: { toggle: :tooltip }, title: remove_link_tooltip_message)
    end

    def remove_link_tooltip_message
      removed = model.removed?

      if removed
        username = model.removed_by.username
        reason = model.removed_reason
        removed_at = h.l(model.removed_at)

        h.t("deletion_details", username: username, removed_at: removed_at, reason: reason)
      else
        h.t("delete")
      end
    end

    def removed_message
      removed_by = model.removed_by
      removed_at = h.datetime_ago_tag(model.removed_at)
      reason = model.removed_reason

      link_to_user_profile = h.link_to(removed_by.username, h.posts_user_path(removed_by))

      h.t("removed_html", username: link_to_user_profile, removed_at: removed_at, reason: reason)
    end
  end
end