namespace :cleanup do
  desc "Cleanup bans"
  task bans: :environment do
    Cleanup::StaleBans.new.call
  end
end
