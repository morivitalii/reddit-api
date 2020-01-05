class AddUniqueIndexOnPostIdInTopics < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :topics, :post_id, unique: true, name: "index_topics_uniqueness", algorithm: :concurrently
  end
end
