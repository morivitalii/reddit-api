class DeleteAdmin
  attr_reader :admin

  def initialize(admin)
    @admin = admin
  end

  def call
    admin.destroy!
  end
end
