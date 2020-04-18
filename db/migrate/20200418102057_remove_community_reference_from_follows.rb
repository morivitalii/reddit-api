class RemoveCommunityReferenceFromFollows < ActiveRecord::Migration[6.0]
  def change
    remove_reference :follows, :community, foreign_key: true, null: false
  end
end
