# frozen_string_literal: true

class StaleBansDeletion
  def call
    Ban.where("end_at < ?", DataRetentionTime.bans).find_each do |ban|
      DeleteBanJob.perform_later(ban.id)
    end
  end
end
