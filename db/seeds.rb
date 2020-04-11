ActiveRecord::Base.transaction do
  user = User.create!(username: "admin", password: "password")
  Admin.create!(user: user)
  Community.create!(url: "all", title: "Readmaru")
end
