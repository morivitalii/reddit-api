class RemoveTagsCountFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :tags_count, :integer, null: false, default: 0
  end
end
