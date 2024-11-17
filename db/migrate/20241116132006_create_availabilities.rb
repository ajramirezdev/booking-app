class CreateAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :availabilities do |t|
      t.references :table, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.date :date, null: false
      t.boolean :available, default: true, null: false

      t.timestamps
    end
  end
end
