class Burger < ApplicationRecord
  has_many :reviews, dependent: :destroy
  [:name, :description, :inspiration, :address, :hours_of_availability].each do |field|
    validates field, presence: true
  end

  scope :dealz, -> { where.not(drink_special: '') }
  scope :most_five, -> {
    (select('burgers.id, count(reviews.id) as reviews_count')
      .joins(:reviews)
      .group("burgers.id")
      .order("reviews_count")
      .reverse_order
      .limit(5)
    )
  }

  scope :top_five, -> {
    (select("burgers.id, burgers.name, AVG(reviews.rating) as reviews_average")
      .joins(:reviews)
      .group('burgers.id')
      .order('reviews_average')
      .reverse_order
      .limit(5)
    )
  }

  def avg_rating
    if self.reviews.size > 0
      return (self.reviews.sum(:rating).to_f / self.reviews.size.to_f).to_f.round
    else
      return -1
    end
  end
end