class RemoveUserReferenceFromBans < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bans, :user, foreign_key: true, null: false
  end
end
