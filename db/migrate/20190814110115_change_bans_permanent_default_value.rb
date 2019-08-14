class ChangeBansPermanentDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :bans, :permanent, from: nil, to: false
  end
end
