class RemoveUserReferenceFromMutes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :mutes, :user, foreign_key: true, null: false
  end
end
