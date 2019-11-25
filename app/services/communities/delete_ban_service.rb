class Communities::DeleteBanService
  attr_reader :ban

  def initialize(ban)
    @ban = ban
  end

  def call
    ban.destroy!
  end
end
