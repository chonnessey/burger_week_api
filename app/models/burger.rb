class Burger < ApplicationRecord
  has_many :reviews, dependent: :destroy
  [:name, :description, :inspiration, :address, :hours_of_availability].each do |field|
    validates field, presence: true
  end
  scope :top_five, -> {
    (select('burgers.id, count(reviews.id) as reviews_count')
      .joins(:reviews)
      .group("burgers.id")
      .order("reviews_count")
      .reverse_order
      .limit(5)
      )}
  scope :dealz, -> { where.not(drink_special: '') }
end