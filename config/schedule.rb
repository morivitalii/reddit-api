set :output, "/home/deploy/app/shared/log/whenever.log"
set :chronic_options, hours24: true

every 6.hours do
  rake "cleanup:all"
end
