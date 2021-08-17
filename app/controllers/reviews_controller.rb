class ReviewsController < ApplicationController
before_action :set_burger
before_action :set_burger_review, only: [:show, :update, :destroy]

  def index
    json_response(@burger.reviews)
  end
  
  def create
    @burger.reviews.create!(review_params)
    # @review = Review.find(params[:id])
    # @review = @burger.reviews.create!(review_params)
    json_response(@burger.reviews.last, :created)
  end

  def show
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
    params.permit(:author, :rating, :content)
  end

  def set_burger
    @burger= Burger.find(params[:burger_id])
  end

  def set_burger_review
    @review = @burger.reviews.find_by!(id: params[:id]) if @burger
  end
end