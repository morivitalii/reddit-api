# frozen_string_literal: true

module CommentableDecorator
  extend ActiveSupport::Concern

  included do
    def comments_link
      comments_count = model.comments_count
      comments_pluralized = h.t('comments_count', count: comments_count)
      link_title = "#{h.number_to_human(comments_count, separator: '.', strip_insignificant_zeros: true, units: { thousand: 'k' })} #{comments_pluralized}"
      link_path = [model]
      link_class = "comments_count"

      h.link_to(link_title, link_path, class: link_class)
    end
  end
end