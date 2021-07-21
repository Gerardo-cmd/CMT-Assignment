class CreateCalls < ActiveRecord::Migration[6.1]
  def change
    create_table :calls do |t|
      t.string :npi

      t.timestamps
    end
  end
end
