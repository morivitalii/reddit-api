class Communities::Posts::MarkAsExplicitService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(explicit: true)
  end
end
