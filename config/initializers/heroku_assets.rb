# Prevent Heroku asset precompilation failing with the 'could not connect to server: Connection refused' error
Rails.application.config.assets.initialize_on_precompile = false
