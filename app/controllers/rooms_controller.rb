class RoomsController < ApplicationController

  # before_action :find_user, only: [ :new, :create, :edit, :update, :destroy ]
  # before_action :find_building, only: [ :new, :create, :edit, :update, :destroy ]

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_building
    @building = Building.find(params[:building_id])
  end
end
