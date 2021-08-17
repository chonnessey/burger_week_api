require 'rails_helper'

describe Burger, type: :model do
  it {should have_many(:reviews)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:inspiration)}
  it {should validate_presence_of(:address)}
  it {should validate_presence_of(:hours_of_availability)}
end
