class Communities::DeleteMute
  include ActiveModel::Model

  attr_accessor :mute

  def call
    mute.destroy!
  end
end
