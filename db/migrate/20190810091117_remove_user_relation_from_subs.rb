class RemoveUserRelationFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subs, :user, foreign_key: true, null: false
  end
end
