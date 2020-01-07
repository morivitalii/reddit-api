class Communities::Posts::RemoveComment
  include ActiveModel::Model

  attr_accessor :comment, :user, :reason

  def call
    comment.update!(
      removed_by: user,
      removed_reason: reason,
      removed_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
