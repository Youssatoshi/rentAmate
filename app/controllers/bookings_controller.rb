class BookingsController < ApplicationController
  before_action :set_profile, only: [:create, :accept, :reject, :cancel, :accept_form, :reject_form, :cancel_form]
  before_action :set_booking, only: [:show, :accept, :reject, :accept_form, :reject_form]

  def new
    @profile = Profile.find(params[:profile_id])
    @booking = Booking.new
  end

  def create
    # Builds a new booking associated with @profile, with the current user as the sender
    @booking = @profile.bookings.build(booking_params.merge(user: current_user))
    @booking.sender_id = current_user.id
    if @booking.save
      redirect_to user_dashboard_path, notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = 'Booking could not be created. Please check the form for errors.'
      render 'profiles/show'
    end
  end


  def show
    @profile = Profile.find(params[:id])
    @bookings = @profile.bookings
  end

  def index
    @bookings = Booking.where(profile_id: params[:profile_id])
  end

  def accept_form
    @profile = Profile.find(params[:profile_id])
    @booking = Booking.find(params[:id])

    render 'accept'
  end

  def reject_form
    @profile = Profile.find(params[:profile_id])
    @booking = Booking.find(params[:id])

    render 'reject'
  end

  def cancel_form
    @profile = Profile.find(params[:profile_id])
    @booking = Booking.find(params[:id])

    render 'cancel'
  end

  def accept
    @profile = Profile.find(params[:profile_id])
    @booking = Booking.find(params[:id])
    update_status('accepted')
  end

  def reject
    update_status('rejected')
  end

# app/controllers/bookings_controller.rb
  def cancel
    @booking = Booking.find(params[:id])
    # Check if the current_user is either the sender or the recipient of the booking
    if @booking.sender_id == current_user.id || @booking.recipient_id == current_user.id
      # Logic to cancel the booking
      @booking.update(status: 'canceled')
      redirect_to user_dashboard_path, notice: 'Booking was successfully canceled.'
    else
      redirect_to user_dashboard_path, alert: 'You are not authorized to cancel this booking.'
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :notes, :recipient_id)
  end

  def update_status(new_status)
    if @booking.update(status: new_status)
      redirect_to user_dashboard_path, notice: "Booking was successfully #{new_status}."
    else
      redirect_to user_dashboard_path, alert: 'There was an error updating the booking status.'
    end
  end

  def set_booking
    @profile = Profile.find(params[:profile_id]) # Ensures profile exists
    @booking = @profile.bookings.find(params[:id]) # Ensures booking exists and belongs to profile
  end

end
