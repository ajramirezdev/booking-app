class Availability < ApplicationRecord
  belongs_to :table
  belongs_to :time_slot

  validates :date, presence: true
  validates :available, inclusion: { in: [ true, false ] }
end
