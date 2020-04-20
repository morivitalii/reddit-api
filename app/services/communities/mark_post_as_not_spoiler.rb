class Communities::MarkPostAsNotSpoiler
  include ActiveModel::Model

  attr_accessor :post

  def call
    post.update!(spoiler: false)
  end
end
