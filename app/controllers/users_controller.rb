class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]


  def new
    @user = User.new
  end

  def create
      @user = User.create(user_params)
      @user.account = current_account
      if @user.save!
        flash[:notice] = "Now add some pictures!"
        redirect_to edit_user_path(@user)
      else
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update!(user_params)
      redirect_to buildings_path
    else
      render :edit
    end
  end

  def myprofile
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender, :phone_number, :user_picture)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
