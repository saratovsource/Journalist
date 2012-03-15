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
    config.autoload_paths += %W( #{config.root}/app/models/extensions #{config.root}/app/models/extensions/site #{config.root}/app/models/extensions/page #{config.root}/app/models/extensions/asset #{config.root}/app/cells/admin)
    
    config.encoding = "utf-8"
    config.filter_parameters << :password
    
    initializer :after_append_asset_paths,
                :group => :all,
                :after => :append_assets_path do
       config.assets.paths.unshift Rails.root.join("vendor", "assets", "stylesheets", "jquery-ui", "cupertino").to_s
    end
    
    config.generators do |g|
      g.test_framework :rspec, :views => false, :fixture => true
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.form_builder :simple_form
      g.template_engine :haml
    end
    
  end
end