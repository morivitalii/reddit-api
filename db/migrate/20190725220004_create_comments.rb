class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.references :parent, foreign_key: { to_table: :comments }, null: false

      t.text :text, null: false

      t.boolean :receive_notifications, null: false, default: true
      t.boolean :ignore_reports, null: false, default: false

      t.integer :comments_count, null: false, default: 0

      t.integer :up_votes_count, null: false, default: 0
      t.integer :down_votes_count, null: false, default: 0

      t.integer :new_score, null: false, default: 0, index: { order: { new_score: :desc } }
      t.float :hot_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.float :best_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.integer :top_score, null: false, default: 0, index: { order: { hot_score: :desc } }
      t.integer :controversy_score, null: false, default: 0, index: { order: { hot_score: :desc } }

      t.references :edited_by, foreign_key: { to_table: :users }
      t.datetime :edited_at

      t.references :approved_by, foreign_key: { to_table: :users }
      t.datetime :approved_at

      t.references :deleted_by, foreign_key: { to_table: :users }
      t.datetime :deleted_at
      t.string :deletion_reason

      t.timestamps

      t.index :created_at
    end
  end
end
