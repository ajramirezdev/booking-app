class RemoveDateFromTimeSlots < ActiveRecord::Migration[8.0]
  def change
    remove_column :time_slots, :date, :date
  end
end
