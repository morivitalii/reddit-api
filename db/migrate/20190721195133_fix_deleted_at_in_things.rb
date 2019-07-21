class FixDeletedAtInThings < ActiveRecord::Migration[5.2]
  def change
    remove_reference :things, :deleted_at
  end
end
