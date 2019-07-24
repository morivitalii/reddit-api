class AddPolymorphicReferenceToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :votable, polymorphic: true, null: false
    add_index :votes, [:votable_type, :votable_id, :user_id], unique: true
  end
end
