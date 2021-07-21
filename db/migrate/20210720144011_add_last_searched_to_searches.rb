class AddLastSearchedToSearches < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :last_searched, :datetime
  end
end
