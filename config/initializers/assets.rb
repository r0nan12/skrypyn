# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( calendar.js )
Rails.application.config.assets.precompile += %w( launch_stripe.js )
Rails.application.config.assets.precompile += %w( validates.js )
Rails.application.config.assets.precompile += %w( submit_order.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css.scss.less, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
