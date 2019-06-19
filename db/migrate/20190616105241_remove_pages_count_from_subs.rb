class RemovePagesCountFromSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :pages_count, :integer, null: false, default: 0
  end
end
