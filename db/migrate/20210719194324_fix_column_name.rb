class FixColumnName < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :histories, :type, :profession_type
  end
end
