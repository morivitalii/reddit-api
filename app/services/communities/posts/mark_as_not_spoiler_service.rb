class Communities::Posts::MarkAsNotSpoilerService
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(spoiler: false)
  end
end
