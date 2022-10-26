class CreatePlumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :plumbers do |t|
      t.string :name
      t.string :address
      t.integer :vehicles
      t.timestamps
    end
  end
end
