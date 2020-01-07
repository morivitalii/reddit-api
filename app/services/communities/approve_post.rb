class Communities::ApprovePost
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.update!(
      approved_by: user,
      removed_by: nil,
      removed_reason: nil,
      approved_at: Time.current,
      removed_at: nil
    )
  end
end
