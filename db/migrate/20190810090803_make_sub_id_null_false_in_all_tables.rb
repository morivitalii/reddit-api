class MakeSubIdNullFalseInAllTables < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bans, :sub_id, false
    change_column_null :blacklisted_domains, :sub_id, false
    change_column_null :contributors, :sub_id, false
    change_column_null :deletion_reasons, :sub_id, false
    change_column_null :moderators, :sub_id, false
    change_column_null :pages, :sub_id, false
    change_column_null :rules, :sub_id, false
    change_column_null :tags, :sub_id, false
  end
end
