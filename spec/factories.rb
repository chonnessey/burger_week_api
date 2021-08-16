FactoryBot.define do 
  factory(:burger) do   
    name {Faker::Food.dish}
    description {Faker::Food.description}
    inspiration {Faker::Fantasy::Tolkien.poem}
    drink_special {Faker::Beer.name}
    address {Faker::Address.street_address}
    hours_of_availability {"#{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :long)} - #{Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :long)}"}
  end
end