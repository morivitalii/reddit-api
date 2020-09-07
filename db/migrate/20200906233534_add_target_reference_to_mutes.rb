class AddTargetReferenceToMutes < ActiveRecord::Migration[6.0]
  def change
    add_reference :mutes, :target, polymorphic: true, null: false
  end
end
