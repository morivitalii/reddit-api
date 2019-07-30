# frozen_string_literal: true

module ApprovableDecorator
  extend ActiveSupport::Concern

  included do
    def approve_link
      approved = model.approved?

      link_icon = h.fa_icon('check')
      link_class = approved ? "approve text-success" : "approve"
      link_path = [:approve, model]

      h.link_to(link_icon, link_path, remote: true, method: :post, class: link_class, data: { toggle: :tooltip }, title: approve_link_tooltip_message)
    end

    def approve_link_tooltip_message
      approved = model.approved?

      if approved
        approved_by_user = model.approved_by.username
        approved_at = h.l(model.approved_at)

        h.t('approved_details', username: approved_by_user, approved_at: approved_at)
      else
        h.t('approve')
      end
    end
  end
end