# frozen_string_literal: true

module BookmarkableDecorator
  extend ActiveSupport::Concern

  included do
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
end