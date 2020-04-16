class CreateExiles < ActiveRecord::Migration[6.0]
  def change
    create_table :exiles do |t|
      t.belongs_to :user, foreign_key: true, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
