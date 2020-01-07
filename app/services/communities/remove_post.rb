class Communities::RemovePost
  include ActiveModel::Model

  attr_accessor :post, :user, :reason

  def call
    ActiveRecord::Base.transaction do
      post.update!(
        removed_by: user,
        approved_by: nil,
        removed_reason: reason,
        removed_at: Time.current,
        approved_at: nil
      )

      post.reports.destroy_all
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
