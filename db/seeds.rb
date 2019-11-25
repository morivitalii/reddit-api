ActiveRecord::Base.transaction do
  user = User.create!(username: "readmaru", password: "password")
  community = Community.create!(url: "all", title: "Readmaru")
  community.moderators.create!(user: user)
end
