Rails.application.config.middleware.use(Warden::Manager) do |manager|
  manager.intercept_401 = false
  manager.default_strategies(:password)
  manager.failure_app = lambda { |env| Api::SignInController.action(env["warden.options"][:action]).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:password) do
  def authenticate!
    service = SignIn.new(
      username: params.dig("username"),
      password: params.dig("password")
    )

    service.valid? ? success!(service.user) : throw(:warden, service: service)
  end
end
