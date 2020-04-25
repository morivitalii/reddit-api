class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.belongs_to :community, foreign_key: true, null: false
      t.string :text
      t.timestamps
      t.index [:community_id, :text], unique: true
    end
  end
end
