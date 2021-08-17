class BurgersController < ApplicationController

  def index
    @burgers = Burger.all
    json_response(@burgers)
  end

  def show
    @burger = Burger.find(params[:id])
    json_response(@burger)
  end

  def create
    @burger = Burger.create!(burger_params)
    json_response(@burger, :created)
  end

  def update
    @burger = Burger.find(params[:id])
    if @burger.update!(burger_params)
      render status: 200, json: {
        message: "This burger has been updated successfully."
      }
    end
  end

  def destroy
    @burger = Burger.find(params[:id])
    if @burger.destroy!
      render status: 200, json: {
        message: "This burger has been successfully destroyed."
      }
    end
  end

  def dealz
    @burgers = Burger.all.dealz
    json_response(@burgers, 200)
  end

  def most_five
    @burgers = Burger.all.most_five.each do |burger|
      burger[:name] = Burger.find(burger.id).name
      burger[:description] = Burger.find(burger.id).description
    end
    json_response(@burgers, 200)
  end

  def top_five
    @burgers = Burger.all.top_five
    json_response(@burgers, 200)
  end

  def rando
    @burger = Burger.order('RANDOM()').first
    json_response(@burger,200)
  end

  private

  def burger_params
    params.permit(:name, :description, :inspiration, :drink_special, :address, :hours_of_availability)
  end

  def set_burger
    @burger = Burger.find(params[:id])
  end

end