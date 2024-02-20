class BookingsController < ApplicationController
  before_action :set_booking, :set_profile, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @booking = @profile.bookings.build(booking_params.merge(user: current_user))

    if @booking.save
      redirect_to user_dashboard_path, notice: 'Booking was successfully created.'
    else
      flash[:alert] = 'Booking could not be created. Please check the form for errors.'
      redirect_to profile_path(@profile)
    end
  end

  # Example for a profile's show action
  def show
    @profile = Profile.find(params[:id])
    @bookings = @profile.bookings # Ensure this is correctly fetching bookings
  end

  def cancel
    if @booking.present? && @booking.cancel!
      redirect_to user_dashboard_path, notice: 'Appointment canceled successfully.'
    else
      redirect_to user_dashboard_path, alert: 'Failed to cancel appointment.'
    end
  end

  def index
    @bookings = Booking.where(profile_id: params[:profile_id])
  end



  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :notes)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
