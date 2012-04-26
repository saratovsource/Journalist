puts "Runing Journalist ..."

require 'rails'
require 'jquery-rails'
require 'json'
require 'devise'
require 'mongoid'
require 'haml'
require 'formtastic'
require 'inherited_resources'
require 'carrierwave'
require 'mimetype_fu'
require 'actionmailer_with_request'
require 'httparty'
require 'dragonfly'
require 'cancan'
require 'RMagick'
require 'cells'
require 'sanitize'

$:.unshift File.dirname(__FILE__)
module Journalist
  class Engine < Rails::Engine
    config.autoload_once_paths += %W( #{config.root}/app/controllers #{config.root}/app/models #{config.root}/app/helpers #{config.root}/app/uploaders)

    # Enabling assets precompiling under rails 3.1
    if Rails.version >= '3.1'
      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( journalist/base.js journalist/base.css j ournalist/thumb_empty.png ournalist/empty.png )
      end
    end

    initializer "journalist.cells" do |app|
      Cell::Base.prepend_view_path("#{config.root}/app/cells")
    end

    initializer "model_render_engine" do |app|
      require 'journalist/render_engine'
    end

    if defined?(query::Rails::Engine)
      initializer :after_append_asset_paths,
                  :group => :all,
                  :after => :append_assets_path do
         config.paths.add File.join(::Jquery::Rails::Engine.root.to_s, "vendor", "assets", "javascripts").to_s, :glob => "*"
      end
    end

    rake_tasks do
    end
  end
end
