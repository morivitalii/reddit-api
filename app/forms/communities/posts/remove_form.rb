class Communities::Posts::RemoveForm
  include ActiveModel::Model

  attr_accessor :post, :user, :reason

  def save
    post.remove!(user, reason)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
