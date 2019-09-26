class RemoveSortingOnAllCommentsIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :comments, column: :hot_score, order: {hot_score: :desc}
    add_index :comments, :hot_score

    remove_index :comments, column: :new_score, order: {new_score: :desc}
    add_index :comments, :new_score
  end
end
