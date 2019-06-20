# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup notifications"
  task notifications: :environment do
    Cleanup::Notifications.call
  end
end
