class SetNullToTrueForUsersEmail < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :email, from: false, to: true
  end
end
