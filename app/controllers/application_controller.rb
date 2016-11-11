class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "Access denied."

    redirect_to root_path
  end

  rescue_from  ActiveRecord::RecordNotFound do |exception|
    render(:file   => "/public/404.html",:status => "404 Error")
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:user_name, :email]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
