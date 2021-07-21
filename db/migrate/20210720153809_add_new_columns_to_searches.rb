class AddNewColumnsToSearches < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :first_name, :string
    add_column :searches, :last_name, :string
    add_column :searches, :city, :string
    add_column :searches, :state, :string
  end
end
