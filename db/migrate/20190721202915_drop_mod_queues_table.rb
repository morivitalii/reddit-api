class DropModQueuesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :mod_queues do |t|
      t.belongs_to :thing, foreign_key: true, index: {unique: true}
      t.timestamps
    end
  end
end
