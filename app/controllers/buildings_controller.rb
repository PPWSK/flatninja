class BuildingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [ :show, :index ]

  before_action :find_user, only: [ :new, :create, :edit, :update, :myrooms ]

  def index
    @buildings = Building.all
    @rooms = Room.where(published_room: true)
  end

  def show
  end

  def new
    @building = Building.new
    @show_map = true
    5.times { @building.rooms.build }
  end

  def create
    @building = @user.buildings.build(building_params)

    @building.rooms.each do |room|
      if room.price.present? && room.square_meter.present? &&
        room.optional_name.present? && room.available_from.present? &&
        room.months_available.present? && room.room_pictures.size > 2
        room.valid_room = true
      else
        room.valid_room = false
      end
    end

    if @building.save!
      flash[:alert] = "Created #{@building.rooms.count} new rooms."
      redirect_to myrooms_user_buildings_path(current_account.user.id, extra: @building.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def myrooms
    @buildings = Building.where(user_id: current_account.user.id)

    if params[:extra] != nil
      @right_rooms = Building.find(params[:extra]).rooms
    else
      if !@buildings.first.nil?
        @right_rooms = @buildings.first.rooms
      else
        redirect_to new_user_building_path(current_account.user.id)
      end
    end
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
