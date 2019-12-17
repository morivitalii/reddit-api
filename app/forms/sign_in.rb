class SignIn
  include ActiveModel::Model

  attr_accessor :username, :password

  validate :validate_credentials

  def validate_credentials
    if user.blank? || !user.authenticate(password)
      errors.add(:username, :invalid_credentials)
    end
  end

  def user
    @_user ||= UsersQuery.new.with_username(username).take
  end
end
