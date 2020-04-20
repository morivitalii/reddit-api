class DeleteAdmin
  include ActiveModel::Model

  attr_accessor :admin

  def call
    admin.destroy!
  end
end
