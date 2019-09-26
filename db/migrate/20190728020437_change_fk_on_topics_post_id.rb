class ChangeFkOnTopicsPostId < ActiveRecord::Migration[5.2]
  def change
    remove_reference :topics, :post, foreign_key: {to_table: :things}, null: false
    add_reference :topics, :post, foreign_key: true, null: false
  end
end
