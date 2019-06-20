# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup posts"
  task posts: :environment do
    Cleanup::Posts.call
  end
end
