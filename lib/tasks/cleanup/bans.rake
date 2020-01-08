namespace :cleanup do
  desc "Cleanup stale bans"
  task bans: :environment do
    Cleanup::StaleBans.new.call
  end
end
