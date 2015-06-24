class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  skip_before_action :create_profile_if_nonexistent, only: [:new, :create]


  def new
    @user = current_account.build_user
  end

  def create
      @user = User.create(user_params)
      @user.account = current_account
      if @user.save
        flash[:notice] = "Please add some pictures!"
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
    if @user.update(user_params)
      flash[:notice] = "User Profile updated"
      redirect_to buildings_path
    else
      flash[:alert] = "Error, not updated!"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender, :phone_number, :user_picture)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
