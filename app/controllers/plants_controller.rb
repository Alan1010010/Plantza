class PlantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search].nil?
      @plants = policy_scope(Plant).order(created_at: :desc)
    else
      @plants = policy_scope(Plant).where("name ILIKE ?", params[:search]).order(created_at: :desc)
    end
  end

  def show
    @plant = Plant.find(params[:id])
    @booking = Booking.new
    authorize @plant
  end

  def new
    @plant = Plant.new
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

  def my_plants
    @plants = current_user.plants
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :address, :price, :photo)
  end
end
