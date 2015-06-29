class RoomPicturesController < ApplicationController
  before_action :find_room, only: [:create, :new, :destroy]
  before_action :find_user
  before_action :find_building
  before_action :find_room_pic, only: [:show, :destroy]

  def show
  end

  def new
    @room_picture = RoomPicture.new
  end

  def create

    @room_picture = @room.room_pictures.build(picture_params)

    if @room_picture.save!
      redirect_to edit_user_building_room_path(@user, @building, @room)
    else
      flash[:alert] = "Picture not saved!"
      redirect_to edit_user_building_room_path(@user, @building, @room)
    end
  end

  def destroy

    if @room_picture.destroy
      redirect_to edit_user_building_room_path(@user, @building, @room)
    end

  end

  private

  def picture_params
    params.require(:room_picture).permit(:file, :file_type)
  end

  def find_room
    @room = Room.find(params[:room_id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_building
    @building = Building.find(params[:building_id])
  end

  def find_room_pic
    @room_picture = RoomPicture.find(params[:id])
  end
end
