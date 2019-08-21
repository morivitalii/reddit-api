# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  include RemovableDecorator
  include ReportableDecorator
  include VotableDecorator
  include CommentableDecorator

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t('edited_html', edited_at: edited_at)
  end

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

  def bookmark_link
    bookmarked = model.bookmark.present?

    link_icon = bookmarked ? h.fa_icon('bookmark') : h.fa_icon('bookmark-o')
    link_path = [model, :bookmarks]
    link_method = bookmarked ? :delete : :post
    link_class = "bookmark"

    h.link_to(link_icon, link_path, remote: true, method: link_method, class: link_class, title: bookmark_link_tooltip_message, data: { toggle: :tooltip })
  end

  def bookmark_link_tooltip_message
    bookmarked = model.bookmark.present?

    bookmarked ? h.t('delete_bookmark') : h.t('bookmark')
  end
end
