class RemoveThingReferenceFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_reference :notifications, :thing, foreign_key: true, null: false
  end
end
