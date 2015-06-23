class UserPicturesController < ApplicationController
  before_action :find_user, only: [:create, :new, :destroy]
  before_action :find_user_pic, only: [:show, :destroy]

  def show
  end

  def new
    @user_picture = UserPicture.new
  end

  def create

    @user_picture = @user.user_pictures.build(picture_params)

    if @user_picture.save!
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def destroy

    if @user_picture.destroy!
      redirect_to edit_user_path(@user)
    end

  end

  private

  def picture_params
    params.require(:user_picture).permit(:file)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_user_pic
    @user_picture = UserPicture.find(params[:id])
  end

end
