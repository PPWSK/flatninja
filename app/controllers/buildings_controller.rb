class BuildingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [ :show, :index ]

  before_action :find_user, only: [ :new, :create, :edit, :update ]
  before_action :get_rooms, only: [ :new, :create ]

  def index

  end

  def show

  end

  def new
    # raise @user.inspect
    @building = Building.new
    @building.id = "-1"
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

  def get_rooms
    @roomArray = [] unless @roomArray
    @room1 = Room.new
    @room2 = Room.new
    @room3 = Room.new
    @room4 = Room.new
    @room5 = Room.new
    @roomArray << @room1 << @room2 << @room3 << @room4 << @room5
end


end
