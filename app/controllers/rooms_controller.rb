class RoomsController < ApplicationController

  before_action :find_user, except: [ :index ]
  before_action :find_building, except: [ :index ]
  before_action :find_room, only: [ :show, :edit, :update ]

  def new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update

    if !room_params[:price].empty? && !room_params[:square_meter].empty? &&
      !room_params[:optional_name].empty? && !room_params[:available_from].empty? &&
      !room_params[:months_available].empty? && @room.room_pictures.size > 2
      @room.valid_room = true
    else
      @room.valid_room = false
    end

    if @room.update(room_params)
      flash[:notice] = "Room updated"
      redirect_to myrooms_user_buildings_path(current_account.user.id, extra: @building.id)
    else
      flash[:alert] = "Error, room not updated!"
      render :edit
    end
  end

  def destroy
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_building
    @building = Building.find(params[:building_id])
  end

  def find_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking)
  end

end
