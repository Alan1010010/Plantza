class PlantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_plant, only: [:show, :edit, :update]

  def index
    @plants = Plant.geocoded
    @markers = @plants.map do |plant|
      {
        lat: plant.latitude,
        lng: plant.longitude
      }
    end
    if params[:search].blank?
      @plants = policy_scope(Plant).order(created_at: :desc)
    else
      @plants = policy_scope(Plant).where("name ILIKE ?", params[:search]).order(created_at: :desc)
    end
  end

  def show
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
