# This migration represents the legacy database structure. It should be considered a starting point

class Structure < ActiveRecord::Migration[5.2]
  def up
    create_table :settings do |t|
      t.string :key, null: false
      t.string :value, null: false

      t.index 'lower(key)', unique: true
    end

    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :forgot_password_token, null: false, index: { unique: true }
      t.integer :posts_points, null: false, default: 0
      t.integer :comments_points, null: false, default: 0
      t.integer :notifications_count, null: false, default: 0
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :moderators_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :staff_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :contributors_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :bans_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :follows_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :forgot_password_email_sent_at, null: false, default: -> { 'now()::timestamp' }

      t.index 'lower(username)', unique: true
      t.index 'lower(email)', unique: true
    end

    create_table :staffs do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: { unique: true }
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :rate_limits do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :key, null: false
      t.integer :hits, null: false, default: 0
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }, index: true
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:user_id, :key], unique: true
    end

    create_table :subs do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :url, null: false
      t.integer :follows_count, null: false, default: 0
      t.string :description
      t.string :title, null: false
      t.integer :tags_count, null: false, default: 0
      t.integer :rules_count, null: false, default: 0
      t.integer :pages_count, null: false, default: 0
      t.integer :deletion_reasons_count, null: false, default: 0
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :moderators_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :rules_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :tags_updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :deletion_reasons_updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index 'lower(url)', unique: true
    end

    create_table :moderators do |t|
      t.belongs_to :sub, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :invited_by, null: false, foreign_key: { to_table: :users }
      t.boolean :master, null: false, default: false
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:sub_id, :user_id], unique: true
    end

    create_table :follows do |t|
      t.belongs_to :sub, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:sub_id, :user_id], unique: true
    end

    create_table :contributors do |t|
      t.belongs_to :sub, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :approved_by, null: false, foreign_key: { to_table: :users }
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:sub_id, :user_id], unique: true
    end

    create_table :bans do |t|
      t.belongs_to :sub, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :banned_by, null: false, foreign_key: { to_table: :users }
      t.string :reason
      t.boolean :permanent, null: false, default: false
      t.integer :days
      t.datetime :end_at, index: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:sub_id, :user_id], unique: true
    end

    create_table :rules do |t|
      t.belongs_to :sub, foreign_key: true
      t.string :title, null: false
      t.string :description
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :deletion_reasons do |t|
      t.belongs_to :sub, foreign_key: true
      t.string :title, null: false
      t.string :description, null: false
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :tags do |t|
      t.belongs_to :sub, null: false, foreign_key: true
      t.string :title, null: false
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index 'sub_id, lower(title)', unique: true
    end

    create_table :blacklisted_domains do |t|
      t.belongs_to :sub, foreign_key: true
      t.string :domain, null: false
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index 'lower(domain)'
      t.index 'sub_id, lower(domain)', unique: true
    end

    create_table :pages do |t|
      t.belongs_to :sub, foreign_key: true
      t.belongs_to :edited_by, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.string :text, null: false
      t.string :text_html, null: false
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :edited_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :logs do |t|
      t.belongs_to :sub, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :loggable_id
      t.string :loggable_type
      t.integer :action, null: false, index: true
      t.json :details, null: false, default: {}
      t.string :details_html
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:loggable_id, :loggable_type]
    end

    create_table :things do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :sub, null: false, foreign_key: true
      t.belongs_to :post, foreign_key: { to_table: :things }
      t.belongs_to :comment, foreign_key: { to_table: :things }
      t.integer :comments_count, null: false, default: 0
      t.integer :up_votes_count, null: false, default: 0
      t.integer :down_votes_count, null: false, default: 0
      t.float :hot_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.float :best_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.integer :top_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.integer :controversy_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }, index: { order: { hot_score: :desc } }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :edited_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :deleted_at
      t.boolean :deleted, index: true
      t.string :deletion_reason
      t.belongs_to :deleted_at, foreign_key: { to_table: :users }
      t.datetime :approved_at
      t.boolean :approved, null: false, default: false
      t.belongs_to :approved_by, foreign_key: { to_table: :users }
      t.string :title
      t.string :text
      t.string :text_html
      t.boolean :explicit, null: false, default: false
      t.boolean :spoiler, null: false, default: false
      t.string :tag
      t.string :url
      t.string :file_data
      t.integer :thing_type, null: false, index: true
      t.integer :content_type, null: false
      t.integer :reports_count, null: false, default: 0
      t.boolean :receive_notifications, null: false, default: false
      t.boolean :ignore_reports, null: false, default: false
    end

    create_table :topics do |t|
      t.belongs_to :post, null: false, foreign_key: { to_table: :things }, index: { unique: true }
      t.jsonb :branch, null: false, default: {}
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :mod_queues do |t|
      t.belongs_to :sub, null: false, foreign_key: true
      t.belongs_to :thing, null: false, foreign_key: true, index: { unique: true }
      t.integer :thing_type, null: false, index: true
      t.integer :queue_type, null: false, index: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :votes do |t|
      t.belongs_to :thing, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :thing_type, null: false, index: true
      t.integer :vote_type, null: false, index: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:user_id, :thing_id], unique: true
    end

    create_table :bookmarks do |t|
      t.belongs_to :thing, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :thing_type, null: false, index: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }

      t.index [:user_id, :thing_id], unique: true
    end

    create_table :notifications do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :thing, null: false, foreign_key: true, index: { unique: true }
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
    end

    create_table :reports do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :thing, null: false, foreign_key: true
      t.datetime :created_at, null: false, default: -> { 'now()::timestamp' }
      t.datetime :updated_at, null: false, default: -> { 'now()::timestamp' }
      t.string :text, null: false

      t.index [:user_id, :thing_id], unique: true
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
