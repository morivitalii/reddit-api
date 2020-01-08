class Communities::Posts::DoNotIgnoreCommentReports
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def call
    comment.update!(ignore_reports: false)
  end
end
