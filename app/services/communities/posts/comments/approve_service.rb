class Communities::Posts::Comments::ApproveService
  attr_reader :comment, :user

  def initialize(comment, user)
    @comment = comment
    @user = user
  end

  def call
    comment.approve!(user)
  end
end
