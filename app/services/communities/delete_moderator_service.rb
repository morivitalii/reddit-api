class Communities::DeleteModeratorService
  attr_reader :moderator

  def initialize(moderator)
    @moderator = moderator
  end

  def call
    moderator.destroy!
  end
end
