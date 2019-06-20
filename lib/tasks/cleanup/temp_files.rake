# frozen_string_literal: true

namespace :cleanup do
  desc "Cleanup temp files"
  task temp_files: :environment do
    Cleanup::TempFiles.call
  end
end