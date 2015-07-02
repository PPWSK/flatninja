class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_account!
  protect_from_forgery with: :exception
  before_action :create_profile_if_nonexistent
  before_action :check_for_messages

  private

  def create_profile_if_nonexistent
    if current_account.present?
      if !current_account.user.present? || !current_account.user.valid?
        redirect_to new_user_path, flash[:notice] => nil, flash[:alert] => nil
      end
    end
  end

  def check_for_messages
    if current_account.present? && current_account.user.present?
      @new_messages = Message.where(recipient_id: current_account.user.id, read: [nil, false] )
    end
  end

end
