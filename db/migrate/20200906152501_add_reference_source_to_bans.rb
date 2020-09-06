class AddReferenceSourceToBans < ActiveRecord::Migration[6.0]
  def change
    add_reference :bans, :source, polymorphic: true, null: false
  end
end
