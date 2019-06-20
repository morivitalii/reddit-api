# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup bans"
  task bans: :environment do
    Cleanup::Bans.call
  end
end
