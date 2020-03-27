class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.belongs_to :user, foreign_key: true, index: { unique: true }
      t.timestamps
    end
  end
end
