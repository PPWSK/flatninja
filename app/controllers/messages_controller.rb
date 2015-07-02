class MessagesController < ApplicationController

  before_action :find_eval, only: [ :new, :create, :show, :index ]
  before_action :find_user, only: [ :new, :create, :show, :index ]
  def new
  end

  def create
  end

  def show
  end

  def index
    @messages = Message.where(recipient_id: current_account.user.id, read: [nil, false] )
  end

  def find_user
    @user = User.find(params[:user_id])
    @user = current_account.user
  end

  def find_eval
    @eval = Evaluation.find(params[:evaluation_id])
  end
end
