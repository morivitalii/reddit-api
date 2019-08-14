unless Rails.env.test?
  ActiveRecord::Base.transaction do
    SignUpForm.new(username: "readmaru", password: "password").save
    SignUpForm.new(username: "AutoModerator", password: "password").save

    Community.create!(url: "all", title: "All")
  end
end