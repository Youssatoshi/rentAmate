class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # Set up profile information
    @profile = current_user.profile || current_user.build_profile

    # Bookings made by the current user
    @bookings = current_user.bookings.order(start_time: :asc)

    # Bookings made on the current user's profile(s)
    # This line assumes that a user has_many :profiles, which may not be true based on your earlier code.
    # Adjust accordingly if a user only has one profile.
    @incoming_bookings = Booking.joins(:profile).where(profiles: { user_id: current_user.id }).order(start_time: :asc)
  end
end
