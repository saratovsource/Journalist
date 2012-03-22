lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

# Maintain your gem's version:
require "journalist/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "journalist"
  s.version     = Journalist::VERSION
  s.authors     = ["Kirillov Ale"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Journalist."
  s.description = "TODO: Description of Journalist."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.require_path = 'lib'

  s.add_dependency 'rails'
  s.add_dependency 'mongo'
  s.add_dependency 'bson'
  s.add_dependency 'bson_ext'
  s.add_dependency 'mongoid'
  s.add_dependency 'mongoid-tree'
  s.add_dependency 'mongoid_taggable'
  
  s.add_dependency 'devise'
  
  s.add_dependency 'haml'
  s.add_dependency 'sass'
  s.add_dependency 'tilt'
  s.add_dependency 'jquery-rails'
  
  # For SpineJs
  s.add_dependency 'eco'
  s.add_dependency 'spine-rails'
  #------------
  
  s.add_dependency 'formtastic'
  s.add_dependency 'inherited_resources'
  s.add_dependency 'cells'
  s.add_dependency 'sanitize'
  s.add_dependency 'russian', '~> 0.6.0'
  s.add_dependency 'RedCloth'
  
  #s.add_dependency 'json_pure'
  
  s.add_dependency 'rmagick'
  s.add_dependency 'mini_magick'
  s.add_dependency 'carrierwave'
  s.add_dependency 'dragonfly'
  s.add_dependency 'rack-cache'
  s.add_dependency 'state_machine'
  
  s.add_dependency 'cancan'
  s.add_dependency 'fog'
  s.add_dependency 'mimetype-fu'
  s.add_dependency 'actionmailer-with-request'
  s.add_dependency 'httparty'

  s.add_dependency 'carrierwave-mongoid'
  s.add_dependency 'delayed_job_mongoid'
  s.add_dependency 'rubyzip'
  s.add_dependency "execjs"
  
  #auth
  s.add_dependency "omniauth-facebook"
  s.add_dependency "omniauth-twitter"

  s.add_development_dependency('bson')
  s.add_development_dependency('haml')
  s.add_development_dependency('mongo')
  s.add_development_dependency('bson_ext')
  s.add_development_dependency('mocha')
  s.add_development_dependency('rspec')
  s.add_development_dependency('database_cleaner')
end
