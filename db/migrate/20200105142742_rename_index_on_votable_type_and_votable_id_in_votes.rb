class RenameIndexOnVotableTypeAndVotableIdInVotes < ActiveRecord::Migration[6.0]
  def change
    rename_index :votes, "index_votes_on_votable_type_and_votable_id_and_user_id", "index_votes_uniqueness"
  end
end
