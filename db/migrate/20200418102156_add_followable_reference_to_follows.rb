class AddFollowableReferenceToFollows < ActiveRecord::Migration[6.0]
  def change
    add_reference :follows, :followable, polymorphic: true, index: false, null: false
  end
end
