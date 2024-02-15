class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

end
