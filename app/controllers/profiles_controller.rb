class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :email, :bio, :phone_number, :address, :profile_picture_url, :age)
  end

end
