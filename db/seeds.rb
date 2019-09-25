ActiveRecord::Base.transaction do
  user = User.create!(username: "readmaru", password: "password")
  community = Community.create!(url: "all", title: "Readmaru")
  Moderator.create!(community: community, user: user)
end