class ChangeParentReferenceNameToCommentInComments < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :parent, foreign_key: { to_table: :comments }
    add_reference :comments, :comment, foreign_key: { to_table: :comments }
  end
end
