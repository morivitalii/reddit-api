class RenameBranchToTreeInTopics < ActiveRecord::Migration[6.0]
  def change
    rename_column :topics, :branch, :tree
  end
end
