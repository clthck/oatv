# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( html5shiv/dist/html5shiv.min.js static.css.scss static.js bubble.css.scss bubble.js head.js )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
