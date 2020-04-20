class Communities::IgnorePostReports
  include ActiveModel::Model

  attr_accessor :post

  def call
    ActiveRecord::Base.transaction do
      post.update!(ignore_reports: true)
      post.reports.destroy_all
    end
  end
end
