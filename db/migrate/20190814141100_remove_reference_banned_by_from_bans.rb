class RemoveReferenceBannedByFromBans < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bans, :banned_by, foreign_key: {to_table: :users}, null: false
  end
end
