class Communities::DeleteBan
  include ActiveModel::Model

  attr_accessor :ban

  def call
    ban.destroy!
  end
end
