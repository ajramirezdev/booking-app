class Table < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0 }
end
