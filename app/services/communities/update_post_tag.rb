class Communities::UpdatePostTag
  include ActiveModel::Model

  attr_accessor :post, :tag

  def call
    ActiveRecord::Base.transaction do
      post.update!(
        tag: tag
      )
    end
  end
end
