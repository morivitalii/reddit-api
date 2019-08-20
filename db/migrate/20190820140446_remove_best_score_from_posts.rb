class RemoveBestScoreFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :best_score, :float, null: false, default: 0, index: true
  end
end
