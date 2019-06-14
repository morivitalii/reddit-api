class RemoveSettings < ActiveRecord::Migration[5.2]
  def change
    drop_table :settings do |t|
      t.string :key
      t.string :value

      t.index "lower(key)", unique: true
    end
  end
end
