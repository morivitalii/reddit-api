class Communities::Posts::MarkAsNotExplicitService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(explicit: false)
  end
end
