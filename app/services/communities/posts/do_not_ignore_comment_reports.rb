class Communities::Posts::DoNotIgnoreCommentReports
  include ActiveModel::Model

  attr_accessor :comment

  def call
    comment.update!(ignore_reports: false)
  end
end
