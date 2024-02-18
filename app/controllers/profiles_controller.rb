class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
