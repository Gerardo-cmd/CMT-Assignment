class RevampSearchTable < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :address, :text
    add_column :searches, :phone_number, :string
    add_column :searches, :taxonomy, :text
  end
end
