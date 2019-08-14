class RemoveSortingOnAllPostsIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :posts, column: :hot_score, order: { hot_score: :desc }
    add_index :posts, :hot_score

    remove_index :posts, column: :new_score, order: { new_score: :desc }
    add_index :posts, :new_score
  end
end
