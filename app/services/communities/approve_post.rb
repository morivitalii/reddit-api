class Communities::ApprovePost
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      post.update!(
        approved_by: user,
        removed_by: nil,
        removed_reason: nil,
        approved_at: Time.current,
        removed_at: nil
      )

      post.reports.destroy_all
    end
  end
end
