set :output, "/home/deploy/app/shared/log/whenever.log"
set :chronic_options, hours24: true

every 1.hour do
  rake "stale_deleted_posts_deletion"
end

every 1.hour do
  rake "stale_bans_deletion"
end

every 1.hour do
  rake "stale_rate_limits_deletion"
end

every 1.hour do
  rake "stale_logs_deletion"
end

every 1.hour do
  rake "stale_notifications_deletion"
end

every 1.hour do
  runner "StaleTempFilesDeletionJob.perform_later"
end