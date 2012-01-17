puts "Runing Journalist ..."

require 'rails'
require 'json/pure'
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
    
    initializer "journalist.cells" do |app|
      Cell::Base.prepend_view_path("#{config.root}/app/cells")
    end
    
    rake_tasks do
    end
  end
end
