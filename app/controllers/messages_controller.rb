class MessagesController < ApplicationController

  # before_action :find_eval, only: [ :new, :create, :show, :index ]
  before_action :find_user, only: [ :new, :create, :show, :index ]

  def new
  end

  def create
    @eval = Evaluation.find(params[:evaluation_id])

    owner_id = @eval.room.building.user_id
    searcher_id = @eval.user_id
    recipient_id = (current_account.user_id == owner_id) ? searcher_id : owner_id

    @message = Message.create(
      sender_id: current_account.user_id,
      recipient_id: recipient_id,
      evaluation_id: params[:evaluation_id],
      content: params[:content])

    recip = User.find(recipient_id)

    if @message.save!
      flash[:notice] = "You've send a new message to " + recip.first_name + "!"
      redirect_to user_messages_path(current_account.user.id, extra: params[:evaluation_id])
    else
      flash[:alert] = "Something went wrong, message not sent!"
      redirect_to user_messages_path(current_account.user.id, extra: params[:evaluation_id])
    end
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
    @user = current_account.user
  end

  # def find_eval
  #   @eval = Evaluation.find(params[:evaluation_id])
  # end
end
