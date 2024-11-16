class ChangeDateNullConstraintInTimeSlots < ActiveRecord::Migration[8.0]
  def up
    change_column :time_slots, :date, :date, null: false
  end

  def down
    change_column :time_slots, :date, :date, null: true
  end
end
