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
      @eval.owner_evaluated = true
      if @eval.save!
        redirect_to root_path
        #TODO: notify
        #TODO: create message for searcher!!
      else
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
