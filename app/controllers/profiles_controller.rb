class ProfilesController < ApplicationController
  def show
    @profile = Profiles.find(params[:id])
  end

  def index
    @profile = Profiles.all
  end
end
