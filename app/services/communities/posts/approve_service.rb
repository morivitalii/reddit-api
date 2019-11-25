class Communities::Posts::ApproveService
  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    post.approve!(user)
  end
end
