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
    if @room.update(room_params)
      flash[:notice] = "Room updated"
      redirect_to edit_user_building_room_path(@user, @building, @room)
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
