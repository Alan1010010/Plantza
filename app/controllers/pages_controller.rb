class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @plants = Plant.all
    @bookings = @plants.map do |plant|
      { num: plant.bookings.count, plant: plant }
    end
    sorted = @bookings.sort_by { |booking| booking["num"] }
    @top_bookings = sorted.first(10)
    @top_plants = @top_bookings.map { |booking| booking[:plant] }
  end
end
