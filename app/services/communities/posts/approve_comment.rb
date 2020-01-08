class Communities::Posts::ApproveComment
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      comment.update!(
        approved_by: user,
        removed_by: nil,
        removed_reason: nil,
        approved_at: Time.current,
        removed_at: nil
      )

      comment.reports.destroy_all
    end
  end
end
