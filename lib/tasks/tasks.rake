# frozen_string_literal: true

task stale_deleted_posts_deletion: :environment do
  StaleDeletedPostsDeletionJob.perform_later
end

task stale_bans_deletion: :environment do
  StaleBansDeletionJob.perform_later
end

task stale_rate_limits_deletion: :environment do
  StaleRateLimitsDeletionJob.perform_later
end

task stale_logs_deletion: :environment do
  StaleLogsDeletionJob.perform_later
end

task stale_notifications_deletion: :environment do
  StaleNotificationsDeletionJob.perform_later
end
