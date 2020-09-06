class AddReferenceCreatedByToBans < ActiveRecord::Migration[6.0]
  def change
    add_reference :bans, :created_by, polymorphic: true, null: false, index: false
  end
end
