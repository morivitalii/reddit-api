class Communities::DeleteModerator
  include ActiveModel::Model

  attr_accessor :moderator

  def call
    moderator.destroy!
  end
end
