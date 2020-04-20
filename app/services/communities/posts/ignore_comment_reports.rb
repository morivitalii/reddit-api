class Communities::Posts::IgnoreCommentReports
  include ActiveModel::Model

  attr_accessor :comment

  def call
    ActiveRecord::Base.transaction do
      comment.update!(ignore_reports: true)
      comment.reports.destroy_all
    end
  end
end
