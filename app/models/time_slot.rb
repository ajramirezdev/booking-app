class TimeSlot < ApplicationRecord
  # Validations
  validates :start_time, :end_time, presence: true
  validates :max_tables, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :end_time_after_start_time
  validate :time_difference_is_exactly_1_hour

  # Ensure end_time is after start_time
  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?
    errors.add(:end_time, "must be after the start time") if end_time <= start_time
  end

  # Custom validation to ensure the time difference between start_time and end_time is exactly 1 hour
  def time_difference_is_exactly_1_hour
    return if start_time.blank? || end_time.blank?
    time_difference = end_time - start_time
    unless time_difference == 3600
      errors.add(:end_time, "must be exactly 1 hour after the start time")
    end
  end
end
