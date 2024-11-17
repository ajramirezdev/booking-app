class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :table
  belongs_to :time_slot
  belongs_to :availability

  validates :number_of_people, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[confirmed cancelled] }
  validates :date, presence: true

  validates_presence_of :user_id, :table_id, :time_slot_id, :availability_id

  # Ensure the reservation is made at least 2 hours in advance
  validate :reservation_time_in_advance

  private

  def reservation_time_in_advance
    if date.present? && date < 2.hours.from_now
      errors.add(:date, "must be at least 2 hours in advance")
    end
  end
end
