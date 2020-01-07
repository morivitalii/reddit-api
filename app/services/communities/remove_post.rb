class Communities::RemovePost
  include ActiveModel::Model

  attr_accessor :post, :user, :reason

  def call
    post.update!(
      removed_by: user,
      removed_reason: reason,
      removed_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
