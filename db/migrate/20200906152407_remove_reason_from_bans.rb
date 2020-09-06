class RemoveReasonFromBans < ActiveRecord::Migration[6.0]
  def change
    remove_column :bans, :reason, :string
  end
end
