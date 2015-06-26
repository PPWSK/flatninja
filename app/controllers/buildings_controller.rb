class BuildingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [ :show, :index ]

  before_action :find_user, only: [ :new, :create, :edit, :update ]

  def index
    @buildings = Building.all
  end

  def show
  end

  def new
    @building = Building.new
    5.times { @building.rooms.build }
  end

  def create
    @building = @user.buildings.build(building_params)

    if @building.save!
      flash[:alert] = "Created #{@building.rooms.count} new rooms."
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
      :number_of_rooms, :number_of_roommates, :garden, :balcony, :pets,
      :cleaning, :garage, :bike_storage, rooms_attributes: [:optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking])
  end

  def find_user
    @user = current_account.user
  end
end
