class AuthController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    auth = Auth.find_by(provider: omniauth['provider'], uid: omniauth['uid'])
    if auth.nil?
      if omniauth.info.email.blank?
        session[:omniauth] = omniauth.except('extra')
        redirect_to auth_new_email_path
      else
        flash['success'] = 'Successfully signed in'
        create_user(:user, omniauth)
      end
    else
      flash['success'] = 'Successfully signed in' if auth.user.confirmed?
      sign_in_and_redirect(:user, auth.user)
    end
  end

  def new_email
    @email = params[:email]
    if @email && session[:omniauth]
      session[:omniauth]['info']['email'] = @email
      create_user(:user, session[:omniauth])
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def create_user(resource, auth)
    user = User.user_create(auth)
    user.skip_confirmation! unless session[:omniauth]
    sign_in_and_redirect(resource, user)
  end
end
