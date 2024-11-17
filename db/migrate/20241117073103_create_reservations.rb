class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.references :availability, null: false, foreign_key: true
      t.date :date
      t.integer :number_of_people
      t.string :status

      t.timestamps
    end
  end
end
