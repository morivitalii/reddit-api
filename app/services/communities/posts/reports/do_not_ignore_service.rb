class Communities::Posts::Reports::DoNotIgnoreService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(ignore_reports: false)
  end
end
