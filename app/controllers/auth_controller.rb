class AuthController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    session['omniauth'] = omniauth.except('extra')
    auth = Auth.find_by(provider: omniauth['provider'], uid: omniauth['uid'])
    if auth.nil?
      user = User.user_create(omniauth)
      if user.valid?
        flash_and_sign_redirect(:user, user)
      else
        redirect_to new_user_registration_path
      end
    else
      flash_and_sign_redirect(:user, auth.user)
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def flash_and_sign_redirect(resource, arg)
    arg.skip_confirmation!
    flash['notice'] = 'Successfully signed in'
    sign_in_and_redirect(resource, arg)
  end
end
