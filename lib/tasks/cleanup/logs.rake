# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup logs"
  task logs: :environment do
    Cleanup::Logs.call
  end
end
