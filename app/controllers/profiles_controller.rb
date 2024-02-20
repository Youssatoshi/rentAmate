class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]

  def index
    @profiles = Profile.where(is_listed: true)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    if @profile.save
     redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new, status: :unprocessable_entity

    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update!(profile_params)
    redirect_to user_dashboard_path
  end

  def toggle_list
    @profile = Profile.find(params[:id])

    # Check if both roles and price are present
    if @profile.roles.present? && @profile.price.present?
      # Toggle is_listed if conditions are met
      @profile.update(is_listed: !@profile.is_listed)
      message = 'Your profile listing has been updated.'
      redirect_to root_path, notice: message
    else
      # Do not toggle and set an appropriate message
      message = 'You need to set both roles and price before listing your profile.'
      redirect_to user_dashboard_path, notice: message
    end

    # Redirect to the dashboard or appropriate path with the message

  end



  def destroy
    @profile = Profile.find(params[:id])
    user = @profile.user

    if @profile.destroy
      if user
        sign_out(user) # Devise helper to sign out the user
        redirect_to new_user_registration_path, notice: 'Your account has been successfully deleted.'
      else
        redirect_to root_path, alert: 'Profile deleted, but no user account was associated.'
      end
    else
      redirect_to @profile, alert: 'Profile could not be deleted.'
    end
  end


  private


  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :email, :bio, :phone_number, :address, :profile_picture_url, :age, :roles, :price)
  end
end
