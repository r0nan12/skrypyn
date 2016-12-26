Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_key'], ENV['facebook_secret'], scope: 'email', info_fields: 'email'
  provider :twitter, ENV['twitter_key'], ENV['twitter_secret']
  provider :google_oauth2, ENV['google_key'], ENV['google_secret']
  on_failure { |env| AuthController.action(:failure).call(env) }
  end
OmniAuth.config.on_failure = Proc.new { |env| AuthController.action(:failure).call(env) }
