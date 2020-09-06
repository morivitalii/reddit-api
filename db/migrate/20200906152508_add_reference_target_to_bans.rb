class AddReferenceTargetToBans < ActiveRecord::Migration[6.0]
  def change
    add_reference :bans, :target, polymorphic: true, null: false
  end
end
