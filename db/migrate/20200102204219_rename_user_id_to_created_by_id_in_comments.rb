class RenameUserIdToCreatedByIdInComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :user_id, :created_by_id
  end
end
