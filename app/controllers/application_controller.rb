class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name,:user_name,:mail_number,:adress,:tel])
  end
  
  
  def after_sign_out_path_for(resource) 
    case resource
    when :admin
      new_admin_session_path         
    when :end_user
      root_path
    end
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      root_path        
    when EndUser
      public_items_path
    end
  end


end
