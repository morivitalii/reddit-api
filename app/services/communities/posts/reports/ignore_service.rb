class Communities::Posts::Reports::IgnoreService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(ignore_reports: true)
  end
end
