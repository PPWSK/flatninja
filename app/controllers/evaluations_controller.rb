class EvaluationsController < ApplicationController

  def create
    @evaluation = Evaluation.create(
      user_id: params[:user_id],
      room_id: params[:room_id],
      status: params[:eval])

    if @evaluation.save
      flash[:notice] = "you have " + (@evaluation.status ? 'liked' : 'disliked') + " prior room!"
      redirect_to root_path
    else
      flash[:alert] = "something went wrong, status: " + params[:eval].to_s
    end

  end
end
