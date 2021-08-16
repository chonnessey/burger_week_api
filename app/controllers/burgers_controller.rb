class BurgersController < ApplicationController

  def index
    name = params[:name]
    @burgers = Burger.search(name)
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

  private

  def burger_params
    params.permit(:author, :content)
  end
end