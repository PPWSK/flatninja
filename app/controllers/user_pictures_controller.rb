class UserPicturesController < ApplicationController
  before_action :find_user, only: [:create, :new, :destroy]

  def show
    @user_picture = UserPicture.find(params[:id])
  end

  def new
    @user_picture = UserPicture.new
  end

  def create

    @user_picture = @user.user_pictures.build(picture_params)

    if @user_picture.save
      redirect_to edit_user_path(
        params[:user_id])
    else
      render :new
    end
  end

  def destroy
    @user_picture = UserPicture.find(params[:id])
    if @user_picture.destroy
      redirect_to edit_user_path(
        params[:user_id])
    end
  end

  private

  def picture_params
    params.require(:user_picture).permit(:file)
  end

  def find_user
     @user = User.find(params[:user_id])
  end
end
