class CreateMutes < ActiveRecord::Migration[5.2]
  def change
    create_table :mutes do |t|
      t.belongs_to :community, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :reason
      t.boolean :permanent, null: false, default: false
      t.integer :days
      t.datetime :end_at
      t.timestamps

      t.index [:community_id, :user_id], unique: true
    end
  end
end
