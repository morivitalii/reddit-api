class RemoveDetailsHtmlFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :details_html, :string
  end
end
