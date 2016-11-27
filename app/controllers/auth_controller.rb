class AuthController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    session['omniauth'] = omniauth.except('extra')
    auth = Auth.find_by( provider: omniauth['provider'], uid: omniauth['uid'] )
    if auth
      flash['notice'] = 'Successfully signed in'
      sign_in_and_redirect(:user, auth.user)
    elsif user = User.find_by(email: omniauth.info.email)
      auth = Auth.create(provider: omniauth.provider, uid: omniauth.uid, user_id: user.id)
      sign_in_and_redirect( :user, auth.user )
    else
      user = User.new
      user.auth_create(omniauth)
      if user.save
        flash['notice'] = 'Successfully signed in'
        sign_in_and_redirect(:user, user)
      else
        redirect_to new_user_registration_path
      end
    end
  end

  def failure
    redirect_to root_path
  end
end