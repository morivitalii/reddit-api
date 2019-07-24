class AddNewScoreToThings < ActiveRecord::Migration[5.2]
  def change
    add_column :things, :new_score, :integer, null: false, default: 0
    add_index :things, :new_score, order: :desc
  end
end
