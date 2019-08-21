# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  include ApprovableDecorator
  include RemovableDecorator
  include ReportableDecorator
  include VotableDecorator
  include BookmarkableDecorator
  include CommentableDecorator

  def edited_at
    edited_at = h.datetime_ago_tag(model.edited_at)

    h.t('edited_html', edited_at: edited_at)
  end
end
