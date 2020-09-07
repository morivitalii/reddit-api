class AddIndexOnEndAtInMutes < ActiveRecord::Migration[6.0]
  def change
    add_index :mutes, :end_at
  end
end
