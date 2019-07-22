class FixTimestamps < ActiveRecord::Migration[5.2]
  def change
    change_column_default :bans, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :bans, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :blacklisted_domains, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :blacklisted_domains, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :bookmarks, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :bookmarks, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :contributors, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :contributors, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :deletion_reasons, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :deletion_reasons, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :follows, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :follows, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :logs, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :logs, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :moderators, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :moderators, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :notifications, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :notifications, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :pages, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :pages, :updated_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :pages, :edited_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :rate_limits, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :rate_limits, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :reports, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :reports, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :rules, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :rules, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :subs, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :subs, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :tags, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :tags, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :things, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :things, :updated_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :things, :edited_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :topics, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :topics, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :users, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :users, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :votes, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :votes, :updated_at, from: -> { "now()::timestamp" }, to: nil

    change_column_default :bans, :created_at, from: -> { "now()::timestamp" }, to: nil
    change_column_default :bans, :updated_at, from: -> { "now()::timestamp" }, to: nil
  end
end
