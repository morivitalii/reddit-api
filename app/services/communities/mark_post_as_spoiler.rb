class Communities::MarkPostAsSpoiler
  include ActiveModel::Model

  attr_accessor :post

  def call
    post.update!(spoiler: true)
  end
end
