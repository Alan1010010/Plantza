class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
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
    params.include(:plant).permit(:name, :address, :price)
  end
end
