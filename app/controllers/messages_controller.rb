class MessagesController < ApplicationController

  # before_action :find_eval, only: [ :new, :create, :show, :index ]
  before_action :find_user, only: [ :new, :create, :show, :index ]

  def new
  end

  def create

  end

  def show
  end

  def index

    @messages = Message.where("recipient_id = ? or sender_id = ?", @user.id, @user.id)
    @messages.each do |msg|
      if msg.recipient_id == @user.id
        msg.read = true
        msg.save!
      end
    end

    @msg_by_eval = @messages.group_by(&:evaluation_id)

    if params[:extra] != nil
      @right_eval = Evaluation.find(params[:extra])
      @right_messages = @right_eval.messages
    else
      if !@msg_by_eval.empty? && !@msg_by_eval.first[0].nil?
        @right_eval = Evaluation.find(@msg_by_eval.first[0])
        @right_messages = @right_eval.messages
      else
        flash[:alert] = "No messages! If you think something went wrong, please contact support service."
        redirect_to root_path
      end
    end

  end

  def find_user
    @user = User.find(params[:user_id])
    @user = current_account.user
  end

  # def find_eval
  #   @eval = Evaluation.find(params[:evaluation_id])
  # end
end
