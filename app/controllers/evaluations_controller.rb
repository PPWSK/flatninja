class EvaluationsController < ApplicationController

  before_action :find_eval, only: [:match_by_owner, :cancel_by_one_party, :one_party_saw_match ]
  before_action :find_user, only: [:match_by_owner, :cancel_by_one_party, :one_party_saw_match ]

  def create
    @evaluation = Evaluation.create(
      user_id: params[:user_id],
      room_id: params[:room_id],
      status: params[:eval])

    if @evaluation.save
      # flash[:notice] = "you have " + (@evaluation.status ? 'liked' : 'disliked') + " prior room!"
      redirect_to root_path
    else
      flash[:alert] = "something went wrong, status: " + params[:eval].to_s
    end
  end

  def match_by_owner
    if @user == @eval.room.building.user
      @eval.owner_evaluated = params[:owner_eval]
      if @eval.save

        if @eval.owner_evaluated == true
        # send message to searcher.

          if @eval.user_id == @user.id
            # means the searcher == writer of message
            recipient = @eval.room.building.user.id
            sender = @eval.user.id
          else
            # means the searcher (@eval.user) is not sender
            # thus searcher must be recipient of message
            recipient = @eval.user.id
            sender = @eval.room.building.user.id
          end

          @message = Message.create!(
            evaluation_id: @eval.id,
            content: "you have a match! Start your conversation..",
            recipient_id: recipient,
            sender_id: sender)

          if @message.save
            redirect_to myrooms_user_buildings_path(current_account.user.id)
          else
            flash[:alert] = "something went wrong"
            redirect_to root_path
          end

        else
          # negative --> no message sent
          redirect_to myrooms_user_buildings_path(current_account.user.id)
        end

      else
        flash[:alert] = "something went wrong"
        redirect_to root_path
      end
    end
  end

  def cancel_by_one_party
  end

  def one_party_saw_match
  end

  def find_eval
    @eval = Evaluation.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

end
