require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, fixtures: true, views: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end




