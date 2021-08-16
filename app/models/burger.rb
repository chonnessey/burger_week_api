class Burger < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :inspiration, presence: true
  validates :address, presence: true
  validates :hours_of_availability, presence: true

end