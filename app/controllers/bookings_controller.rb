class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.plant
    if @booking.save
      redirect_to bookings_index_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
