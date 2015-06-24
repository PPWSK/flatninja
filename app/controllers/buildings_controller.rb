class BuildingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [ :show, :index ]

  before_action :find_user, only: [ :new, :create, :edit, :update ]

  def index

  end

  def show

  end

  def new
    # raise @user.inspect
    @building = Building.new
  end

  def create
    @building = Building.create(building_params)
    @building.user = @user
      if @building.save
        redirect_to buildings_path
      else
        render :new
      end
  end

  def edit

  end

  def update

  end

  private

  def building_params
    params.require(:building).permit(:name, :building_type, :location,
      :number_of_rooms, :number_of_roommates, :garden, :balcony, :bathroom,
      :kitchen, :pets, :cleaning, :garage, :bike_storage)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

end
