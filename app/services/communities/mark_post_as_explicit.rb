class Communities::MarkPostAsExplicit
  include ActiveModel::Model

  attr_accessor :post

  def call
    post.update!(explicit: true)
  end
end
