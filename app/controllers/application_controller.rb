class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "Access denied."

    redirect_to root_path
  end

  rescue_from  ActiveRecord::RecordNotFound do |exception|
    render(:file   => "/public/404.html",:status => "404 Error")
  end

end
