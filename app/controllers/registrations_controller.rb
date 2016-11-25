class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  protected

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.auth_create(session[:omniauth])
      @user.valid?
    end
  end
end