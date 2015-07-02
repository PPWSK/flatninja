class MessagesController < ApplicationController

  before_action :find_eval, only: [ :new, :create, :show ]
  before_action :find_user, only: [ :new, :create, :show ]
  def new
  end

  def create
  end

  def show
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_eval
    @eval = Evaluation.find(params[:evaluation_id])
  end
end
