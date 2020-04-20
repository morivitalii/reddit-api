class Communities::MarkPostAsNotExplicit
  include ActiveModel::Model

  attr_accessor :post

  def call
    post.update!(explicit: false)
  end
end
