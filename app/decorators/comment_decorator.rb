# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  include EditableDecorator
  include ApprovableDecorator
  include RemovableDecorator
  include ReportableDecorator
  include VotableDecorator
  include BookmarkableDecorator
  include CommentableDecorator
end
