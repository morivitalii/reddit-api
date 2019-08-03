unless Rails.env.test?
  ActiveRecord::Base.transaction do
    readmaru = SignUp.new(username: "readmaru", password: "password").save
    SignUp.new(username: "AutoModerator", password: "password").save

    Sub.create!(user: readmaru, url: "all", title: "All")
  end
end