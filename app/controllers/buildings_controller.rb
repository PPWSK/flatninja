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
    @building.rooms.build
    # @building.id = "-1"
  end

  def create

    created_rooms = 0

    @building = Building.create(building_params)
    @building.user = @user

    if @building.save

      @room_array.each_with_index do |room, i|
        i+=1
        how_many_room_fields_filled = 0

        rooms_params["room"+i.to_s].each do |x|
          how_many_room_fields_filled += 1 if (!x[1].length == 0 && !x[1] == "0")
        end

        if how_many_room_fields_filled >= 2
          @room = @building.rooms.build(rooms_params["room"+i.to_s])
          if @room.save
            created_rooms += 1
          else
            raise @room.inspect
          end
        end
      end

      flash[:alert] = "room_size:" + @building.rooms.size.to_s + ", created rooms: " + created_rooms.to_s
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
      :cleaning, :garage, :bike_storage )
  end

  def rooms_params
    params.require(:building).permit(
      room1: [ :optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking ],
      room2: [ :optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking ],
      room3: [ :optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking ],
      room4: [ :optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking ],
      room5: [ :optional_name, :price, :square_meter, :available_from, :months_available,
        :private_bathroom, :private_kitchen, :private_balcony,
        :private_garden, :private_parking ])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def get_rooms
    @room_array = [] unless @room_array
    @room1 = Room.new
    @room2 = Room.new
    @room3 = Room.new
    @room4 = Room.new
    @room5 = Room.new
    @room_array << @room1 << @room2 << @room3 << @room4 << @room5
end


end
