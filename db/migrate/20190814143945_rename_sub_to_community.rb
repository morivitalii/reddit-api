class RenameSubToCommunity < ActiveRecord::Migration[5.2]
  def change
    rename_table :subs, :communities
    rename_index :communities, :index_subs_on_lower_url, :index_communities_on_lower_url

    remove_index :bans, :sub_id
    remove_index :bans, column: [:sub_id, :user_id], unique: true
    rename_column :bans, :sub_id, :community_id
    add_index :bans, :community_id
    add_index :bans, [:community_id, :user_id], unique: true

    remove_index :moderators, :sub_id
    remove_index :moderators, column: [:sub_id, :user_id], unique: true
    rename_column :moderators, :sub_id, :community_id
    add_index :moderators, :community_id
    add_index :moderators, [:community_id, :user_id], unique: true

    remove_index :follows, :sub_id
    remove_index :follows, column: [:sub_id, :user_id], unique: true
    rename_column :follows, :sub_id, :community_id
    add_index :follows, :community_id
    add_index :follows, [:community_id, :user_id], unique: true

    remove_index :comments, :sub_id
    rename_column :comments, :sub_id, :community_id
    add_index :comments, :community_id

    remove_index :posts, :sub_id
    rename_column :posts, :sub_id, :community_id
    add_index :posts, :community_id

    remove_index :reports, :sub_id
    rename_column :reports, :sub_id, :community_id
    add_index :reports, :community_id

    remove_index :rules, :sub_id
    rename_column :rules, :sub_id, :community_id
    add_index :rules, :community_id
  end
end
