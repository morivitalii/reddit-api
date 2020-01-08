class Communities::Posts::IgnoreCommentReports
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def call
    ActiveRecord::Base.transaction do
      comment.update!(ignore_reports: true)
      comment.reports.destroy_all
    end
  end
end
