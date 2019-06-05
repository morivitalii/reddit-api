Rails.application.config.middleware.use(Warden::Manager) do |manager|
  manager.intercept_401 = false
  manager.default_strategies(:password)
  manager.failure_app = lambda { |env| SignInController.action(env["warden.options"][:action]).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:password) do
  def authenticate!
    form = SignIn.new(
      username: params.dig("sign_in", "username"),
      password: params.dig("sign_in", "password")
    )

    form.valid? ? success!(form.user) : throw(:warden, form: form)
  end
end