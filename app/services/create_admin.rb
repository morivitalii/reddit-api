class CreateAdmin
  include ActiveModel::Model

  attr_accessor :user_id
  attr_reader :admin

  def call
    @admin = Admin.create!(
      user_id: user_id
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
