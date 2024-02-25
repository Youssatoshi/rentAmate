class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || current_user.build_profile
    @bookings = current_user.bookings.order(start_time: :asc)
    @incoming_bookings = Booking.joins(:profile).where(profiles: { user_id: current_user.id }).order(start_time: :asc)
    my_bookings
  end

  def my_bookings
    @bookings = current_user.profile.bookings.all # Adjust this as needed to fetch the bookings relevant to the user

    # Count bookings by status
    @bookings_by_status = @bookings.group_by(&:status).transform_values(&:count)

    # Convert nil keys to "free"
    if @bookings_by_status.key?(nil)
      @bookings_by_status["free"] = @bookings_by_status.delete(nil)
    end
  end
end
