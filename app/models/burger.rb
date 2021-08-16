class Burger < ApplicationRecord
  has_many :reviews, dependent: :destroy
  [:name, :description, :inspiration, :address, :hours_of_availability].each do |field|
    validates field, presence: true
  end

end