class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string :npi
      t.string :name
      t.string :address
      t.string :type
      t.string :taxonomy

      t.timestamps
    end
  end
end
