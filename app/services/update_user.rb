class UpdateUser
  include ActiveModel::Model

  attr_accessor :user, :email, :password

  def call
    user.update!(email: email, password: password)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
