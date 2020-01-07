class Communities::ApprovePost
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.update!(
      approved_by: user,
      approved_at: Time.current
    )
  end
end
