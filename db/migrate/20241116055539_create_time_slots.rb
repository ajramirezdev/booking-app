class CreateTimeSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :time_slots do |t|
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :max_tables, null: false, default: 0
      t.timestamps
    end
  end
end
