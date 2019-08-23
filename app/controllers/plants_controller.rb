class PlantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_plant, only: [:show, :edit, :update]

  def index
    if params[:navsearch].blank? && params[:search].blank? && params[:from].blank? && params[:to].blank?
      @plants = policy_scope(Plant).order(created_at: :desc)
    else
      @plants = policy_scope(Plant)
      # @plants = @plants.where("name ILIKE ?", "%#{params[:navsearch]}%").order(created_at: :desc) if params[:navsearch].present?
      @plants = @plants.search_name_and_description(params[:navsearch]) if params[:navsearch].present?
      if params[:to]&.any? && params[:from]&.any? && !params[:to][0].blank? && !params[:from][0].blank?
        from = Date.parse(params[:from][0]).beginning_of_day
        to = Date.parse(params[:to][0]).end_of_day
        relevant_bookings = Booking.where(start_date: from..to).or(Booking.where(end_date: from..to)).or(Booking.where("start_date < ? AND end_date > ?", from, to))
        ids = relevant_bookings.map(&:plant_id)
        @plants = @plants.where.not(id: ids)
      end
      @plants = @plants.near(params[:search], 10) if params[:search].present?
    end
    @markers = @plants.map do |plant|
      {
        lat: plant.latitude,
        lng: plant.longitude
      }
    end
  end

  def show
    @plant = Plant.find(params[:id])
    @review = Review.new(params[:plant_id])
    @booking = Booking.new
    authorize @plant
  end

  def new
    @plant = Plant.new
    authorize @plant
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    authorize @plant
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  def edit
    authorize @plant
  end

  def update
    authorize @plant
    @plant.update(plant_params)
    redirect_to plant_path(@plant)
  end

  def my_plants
    @plants = current_user.plants
    skip_authorization
  end

  def destroy
    @plant = Plant.find(params[:id])
    authorize @plant
    @plant.destroy
    redirect_to my_plants_path
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def plant_params
    params.require(:plant).permit(:name, :address, :description, :price, :photo)
  end
end
