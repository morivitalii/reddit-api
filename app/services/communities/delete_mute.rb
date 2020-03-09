class Communities::DeleteMute
  attr_reader :mute

  def initialize(mute)
    @mute = mute
  end

  def call
    mute.destroy!
  end
end
