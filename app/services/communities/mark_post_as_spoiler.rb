class Communities::MarkPostAsSpoiler
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    post.update!(spoiler: true)
  end
end
