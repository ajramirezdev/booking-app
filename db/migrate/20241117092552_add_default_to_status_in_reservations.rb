class AddDefaultToStatusInReservations < ActiveRecord::Migration[8.0]
  def change
    change_column_default :reservations, :status, 'confirmed'
  end
end
