class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  rescue_from ::SocketError do |error|
    flash[:danger] = error.message
    redirect_to :back
  end

  rescue_from ::TypeError do |error|
    flash[:danger] = 'Wrong data'
    redirect_to :back
  end

  rescue_from CanCan::AccessDenied do
    flash[:danger] = 'Access denied'
    redirect_to :back
  end

  rescue_from ActiveRecord::RecordNotFound do
    render(file: :'/public/404.html', status: 404)
  end

  rescue_from Stripe::CardError do |error|
    flash[:error] = error.message
    redirect_to new_stripe_path
  end

  def set_locale
    session[:locale] = params[:locale] if params.key?(:locale)
    I18n.locale = session[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    attrs_for_user = [:user_name, :email]
    devise_parameter_sanitizer.permit :sign_up, keys: attrs_for_user
    devise_parameter_sanitizer.permit :account_update, keys: attrs_for_user
  end
end
