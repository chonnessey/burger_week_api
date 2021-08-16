# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Burger.destroy_all
Review.destroy_all

class Seed

  def self.begin
    
    seed = Seed.new
    seed.generate_burgers
    seed.generate_reviews
  end

  def generate_burgers
    37.times do |i|
      burger = Burger.create!(
        name: Faker::Food.dish,
        description: Faker::Food.description,
        inspiration: Faker::Fantasy::Tolkien.poem,
        drink_special: Faker::Beer.name,
        address: Faker::Address.street_address,
        hours_of_availability: "#{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :long)} - #{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :long)}"
      )
      puts "#{burger.name} burger created!"
    end
  end

  def generate_reviews

    @burgers = Burger.all

    @burgers.each do |burger|
    rand(0..5).times do
      Review.create!(
        author: Faker::Name.name,
        rating: rand(1..5),
        content: Faker::Hipster.sentences(number: 3).join(" "),
        burger_id: burger.id,
      )
      end
    end
    p "Created #{Review.count} Reviews for #{Burger.count} burgers."
  end
end

Seed.begin