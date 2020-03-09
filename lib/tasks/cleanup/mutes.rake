namespace :cleanup do
  desc "Cleanup stale mutes"
  task mutes: :environment do
    Cleanup::StaleMutes.new.call
  end
end
