namespace :cleanup do
  desc "Cleanup bans"
  task bans: :environment do
    Cleanup::BansService.new.call
  end
end
