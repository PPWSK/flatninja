class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end

  def create
      @user = User.create(user_params)
      @user.account = current_account
      if @user.save
        redirect_to user_path(@user)
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
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def myprofile
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender, :phone_number)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
