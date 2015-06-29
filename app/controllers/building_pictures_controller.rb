class BuildingPicturesController < ApplicationController
  before_action :find_building, only: [:create, :new, :destroy]
  before_action :find_building_pic, only: [:show, :destroy]

  def show
  end

  def new
    @building_picture = BuildingPicture.new
  end

  def create

    @building_picture = @building.building_pictures.build(picture_params)

    if @building_picture.save
      redirect_to edit_building_path(@building)
    else
      flash[:alert] = "Picture not saved!"
      redirect_to edit_building_path(@building)
    end
  end

  def destroy

    if @building_picture.destroy
      redirect_to edit_building_path(@building)
    end

  end

  private

  def picture_params
    params.require(:building_picture).permit(:file, :file_type)
  end

  def find_building
    @building = Building.find(params[:building_id])
  end

  def find_building_pic
    @building_picture = BuildingPicture.find(params[:id])
  end
end
