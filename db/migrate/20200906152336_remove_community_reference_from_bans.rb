class RemoveCommunityReferenceFromBans < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bans, :community, foreign_key: true, null: false
  end
end
