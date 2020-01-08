namespace :cleanup do
  desc "Cleanup temp files"
  task temp_files: :environment do
    Cleanup::TempFiles.new.call
  end
end
