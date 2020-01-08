class Communities::IgnorePostReports
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    ActiveRecord::Base.transaction do
      post.update!(ignore_reports: true)
      post.reports.destroy_all
    end
  end
end
