class Communities::DoNotIgnorePostReports
  include ActiveModel::Model

  attr_accessor :post

  def call
    post.update!(ignore_reports: false)
  end
end
