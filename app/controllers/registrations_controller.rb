class RegistrationsController < Devise::RegistrationsController
  def create
    resource = User.find_by(email: sign_up_params[:email])
    if resource && session[:omniauth]
      auth = Auth.create!(provider: session[:omniauth]['provider'], uid: session[:omniauth]['uid'], user_id: resource.id)
      sign_in(resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      super
    end
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