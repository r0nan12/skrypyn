Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '545881105600878', '55d90f37cf20f197c7a76a0de7a95e8a', scope: 'email', info_fields: 'email'
  provider :twitter, 'xO9WMbcs6frVjiFlT6orDJONz', 'ls1uR2G8ZFrtAmhq9jVAoXEBehI3Gc4ydEBpLjLiRHH0tveAWT'
  provider :google_oauth2, '957106029085-johdroc42aid9a1lkl3p23hob4qrmmod.apps.googleusercontent.com', 'LhR5ZohFa1dIq50rdD35UHqX'
  on_failure { |env| AuthController.action(:failure).call(env) }
  end
OmniAuth.config.on_failure = Proc.new { |env| AuthController.action(:failure).call(env) }
