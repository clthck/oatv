class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # CanCanCan
  load_and_authorize_resource

  add_breadcrumb "<i class='fa fa-home'></i> Home".html_safe, :user_root_path

  Parameters = ActionController::Parameters

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
  	new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |p|
      p.permit :email, :password, :password_confirmation, :role_id, :club_id,
        club_attributes: [:name, :country_id, :active]
    end

  	devise_parameter_sanitizer.for(:account_update) do |p|
  		p.permit :email, :password, :password_confirmation, :current_password, 
  			profile_attributes: [:id, :full_name, :birthday, :gender, :introduction, :avatar]
  	end
  end

end
