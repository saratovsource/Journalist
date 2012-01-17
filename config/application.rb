require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "mongoid/railtie"

# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, Rails.env

module Journalist
  class Application < Rails::Application
    #TODO Autoload
    #config.autoload_paths += %W( #{config.root}/app/models/extensions #{config.root}/app/models/extensions/site #{config.root}/app/models/extensions/page #{config.root}/app/models/extensions/asset #{config.root}/app/cells/admin)
    
    config.encoding = "utf-8"
    config.filter_parameters << :password
  end
end