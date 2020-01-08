class Communities::Posts::RemoveComment
  include ActiveModel::Model

  attr_accessor :comment, :user, :reason

  def call
    ActiveRecord::Base.transaction do
      comment.update!(
        removed_by: user,
        approved_by: nil,
        removed_reason: reason,
        removed_at: Time.current,
        approved_at: nil
      )

      comment.reports.destroy_all
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
