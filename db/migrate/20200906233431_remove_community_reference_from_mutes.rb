class RemoveCommunityReferenceFromMutes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :mutes, :community, foreign_key: true, null: false
  end
end
