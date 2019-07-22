class RemoveTextHtmlFromThings < ActiveRecord::Migration[5.2]
  def change
    remove_column :things, :text_html, :string
  end
end
