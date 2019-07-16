class RemoveContributorsUpdatedAtFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :contributors_updated_at, null: false, default: -> { "now()::timestamp" }
  end
end
