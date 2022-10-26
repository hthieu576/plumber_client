class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :description
      t.belongs_to :client, index: true, foreign_key: true, null: false
      t.belongs_to :plumber, index: true, foreign_key: true, null: false
      t.datetime :time_period
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
