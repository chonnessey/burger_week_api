class ReviewsController < ApplicationController

  def index
    @reviews = Review.where(burger_id: params[:burger_id])
    json_response(@reviews)
  end
  
  def create
    @burger = Burger.find(params[:burger_id])
    @review = @burger.reviews.create!(review_params)
    json_response(@review, :created)
  end

  def show
    @burger = Burger.find(params[:burger_id])
    @review = Review.find(params[:id])
    json_response(@review)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update!(review_params)
      render status: 200, json: {
        message: "This review has been updated successfully."
      }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      render status: 200, json: {
        message: "This review has been deleted successfully."
      }
    end
  end

  private
    def review_params
      params.require(:review).permit(:author, :rating, :content)
    end

end