class AddSubToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :sub, foreig_key: true, null: false
  end
end
