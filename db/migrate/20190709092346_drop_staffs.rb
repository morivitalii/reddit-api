class DropStaffs < ActiveRecord::Migration[5.2]
  def up
    drop_table :staffs
    remove_column :users, :staff_updated_at
  end

  def down
    create_table :staffs do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: {unique: true}
      t.datetime :created_at, null: false, default: -> { "now()::timestamp" }
      t.datetime :updated_at, null: false, default: -> { "now()::timestamp" }
    end

    add_column :users, :staff_updated_at, null: false, default: -> { "now()::timestamp" }
  end
end
