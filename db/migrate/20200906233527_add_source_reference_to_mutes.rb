class AddSourceReferenceToMutes < ActiveRecord::Migration[6.0]
  def change
    add_reference :mutes, :source, polymorphic: true, null: false
  end
end
