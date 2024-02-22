class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || current_user.build_profile
    @bookings = current_user.bookings.order(start_time: :asc)
    @incoming_bookings = Booking.joins(:profile).where(profiles: { user_id: current_user.id }).order(start_time: :asc)
  end
end
