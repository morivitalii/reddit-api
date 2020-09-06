class AddReferenceUpdatedByToBans < ActiveRecord::Migration[6.0]
  def change
    add_reference :bans, :updated_by, polymorphic: true, null: false, index: false
  end
end
