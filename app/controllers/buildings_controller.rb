class BuildingsController < ApplicationController
  skip_before_action :authenticate_account!, only: [ :show, :index ]

  before_action :find_user, only: [ :new, :create, :edit, :update, :myrooms ]

  def index
    @offer_side = false

    @all_rooms = Room.where(published_room: true)
    @evaluated_rooms = []
    @liked_rooms = []
    @my_rooms = []

    if !current_account.nil?
      @all_evals = Evaluation.where(user_id: current_account.user.id)

      @all_evals.each do |eval|
        @liked_rooms << @all_rooms.detect {|r| r.published_room && r.id == eval.room_id && eval.status }
        @evaluated_rooms << @all_rooms.detect {|r| r.id == eval.room_id }
      end

      @temp_my_rooms = @all_rooms.select {|r| r.building.user_id == current_account.user.id }
      @temp_my_rooms.each do |tmr|
        @my_rooms << tmr
      end
    end

    @new_rooms = @all_rooms - @evaluated_rooms - @my_rooms

    if !@new_rooms.empty?
      @new_room = @new_rooms.sample

      @markers = Gmaps4rails.build_markers(@new_room.building) do |room, marker|
        marker.lat room.latitude
        marker.lng room.longitude
      end
    end
  end

  def show
    @offer_side = false
  end

  def new
    @offer_side = true
    @building = Building.new
    @show_map = true
    5.times { @building.rooms.build }
  end

  def create
    @offer_side = true
    # raise building_params["rooms_attributes"]["0"].inspect
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
      flash[:alert] = "Created #{@building.rooms.count} new rooms. Now please add some pictures."
      redirect_to myrooms_user_buildings_path(current_account.user.id, extra: @building.id)
      # TODO: redirect to edit instead of myrooms in order to upload pics.
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def myrooms
    @offer_side = true
    @buildings = Building.where(user_id: current_account.user.id)

    if params[:extra] != nil
      @right_building = Building.find(params[:extra])
      @right_rooms = @right_building.rooms
    else
      if !@buildings.first.nil?
        @right_building = @buildings.first
        @right_rooms = @right_building.rooms
      else
        redirect_to new_user_building_path(current_account.user.id)
      end
    end

    if !@right_building.nil?
      @markers = Gmaps4rails.build_markers(@right_building) do |room, marker|
        marker.lat room.latitude
        marker.lng room.longitude
      end
    end

    @all_evals = Evaluation.all
    @my_rooms_evals = []

    @buildings.each do |mybuilding|
      mybuilding.rooms.each do |myroom|
        # @my_rooms_evals << Evaluation.where(room_id: myroom.id, status: true)
        @my_rooms_evals << @all_evals.detect {|e| e.room_id == myroom.id && e.status && e.owner_evaluated != true }
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
