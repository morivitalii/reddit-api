# frozen_string_literal: true

module RemovableDecorator
  extend ActiveSupport::Concern

  included do
    def remove_link
      deleted = model.removed?

      link_icon = h.fa_icon("trash")
      link_path = [:remove, model]
      link_class = deleted ? "remove text-danger" : "remove"

      h.link_to(link_icon, link_path, remote: true, class: link_class, data: { toggle: :tooltip }, title: remove_link_tooltip_message)
    end

    def remove_link_tooltip_message
      deleted = model.removed?

      if deleted
        username = model.deleted_by.username
        reason = model.deletion_reason
        deleted_at = h.l(model.deleted_at)

        h.t("deletion_details", username: username, deleted_at: deleted_at, reason: reason)
      else
        h.t("delete")
      end
    end

    def removed_message
      deleted_by = model.deleted_by
      deleted_at = h.datetime_tag(model.deleted_at, :ago)
      reason = model.deletion_reason

      link_to_user_profile = h.link_to(deleted_by.username, h.posts_user_path(deleted_by))

      h.t("deleted_html", username: link_to_user_profile, deleted_at: deleted_at, reason: reason)
    end
  end
end