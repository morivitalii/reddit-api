class RemoveReferenceInvitedByFromModerators < ActiveRecord::Migration[5.2]
  def up
    remove_reference :moderators, :invited_by, foreign_key: { to_table: :users }, null: false
  end
end
