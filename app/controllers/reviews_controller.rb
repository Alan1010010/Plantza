class ReviewsController < ApplicationController
  before_action :set_plant, only: [:new, :create, :destroy]
  
  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(reviews_params)
    @review.plant = @plant
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  private

  def reviews_params
    params.require(:review).permit(:content, :rating)
  end

  def set_plant
    @plant = Plant.find(params[:plant_id])
    authorize @plant
  end
end

# 4. Policy: should create only if user has not a review for the same plant: user.reviews.find_by(plant_id: record.plant_id).nil?