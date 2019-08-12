class AddSubReferenceToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :sub, foreign_key: true, null: false
  end
end
