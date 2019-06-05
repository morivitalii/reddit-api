ActiveRecord::Base.transaction do
  SignUp.new(username: "readmaru", password: "password").save!
  SignUp.new(username: "AutoModerator", password: "password").save!
end