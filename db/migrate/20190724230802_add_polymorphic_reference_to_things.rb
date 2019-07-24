class AddPolymorphicReferenceToThings < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :notifiable, polymorphic: true, null: false
    add_index :notifications, [:notifiable_type, :notifiable_id, :user_id], unique: true, name: :index_notifications_uniqueness
  end
end
