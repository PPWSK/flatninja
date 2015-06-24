class RegistrationsController < Devise::RegistrationsController
  skip_before_action :create_profile_if_nonexistent
  protected

  def after_sign_up_path_for(resource)
    new_user_path
  end

  # def after_inactive_sign_up_path_for(resource)
  #   super
  # end
end
