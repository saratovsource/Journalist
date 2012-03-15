require 'mimetype_fu'
require 'devise'
require 'rack/cache'
require 'dragonfly'
require 'russian'
require 'mongoid/tree'
require 'mongoid_taggable'
require 'carrierwave/mongoid'
require 'state_machine'
require 'jquery-rails'
require 'spine-rails'
require 'eco'
require 'execjs'
require 'tilt'

require 'omniauth-facebook'
require 'omniauth-twitter'

require 'journalist/core_ext'
require 'journalist/uniq_generator'
require 'journalist/logger'
require 'journalist/regexps'
require 'journalist/configuration'
require 'journalist/godmode_responder'
require 'journalist/routing'
require 'journalist/dragonfly'
require 'journalist/middlewares'
require 'journalist/hosting'
require 'journalist/mongoid'
require 'journalist/document'
require 'journalist/acl'
require 'journalist/text_utils'
require 'journalist/formatters'
require 'journalist/render_factory'

module Journalist
  
  class << self
    attr_accessor :config
    
    def config
      self.config = Configuration.new unless @config
      @config
    end
  end
    
  def self.engine?
    self.const_defined?('Engine')
  end
  
  def self.default_site_template_present?
    File.exists?(self.default_site_template_path)
  end
  
  def self.default_site_template_path
    File.join(Rails.root, 'tmp/default_site_template.zip')
  end
  
  def self.configure
    self.config ||= Configuration.new

    yield(self.config)

    after_configure
  end
  
  def self.after_configure
    self.define_subdomain_and_domains_options
    
    # multi sites support
    self.configure_multi_sites
    
    # hosting platform
    self.configure_hosting
    
    # Devise
    mail_address = self.config.mailer_sender
    ::Devise.mailer_sender = mail_address =~ /.+@.+/ ? mail_address : "#{mail_address}@#{Journalist.config.domain}"
    
    # cookies stored in mongodb (mongoid_store)
    Rails.application.config.session_store :mongoid_store, {
      :key => self.config.cookie_key
    }
    
    # add middlewares (dragonfly, font, seo, ...etc)
    self.add_middlewares
  end
  
  def self.add_middlewares
    self.app_middleware.insert 0, '::Dragonfly::Middleware', :images
    if self.rack_cache?
      self.app_middleware.insert_before 'Dragonfly::Middleware', '::Journalist::Middlewares::Cache', self.config.rack_cache
    end
    
    self.app_middleware.insert_before Rack::Lock, '::Journalist::Middlewares::Fonts', :path => %r{^/fonts}
    self.app_middleware.use '::Journalist::Middlewares::SeoTrailingSlash'
  end
  
  def self.configure_multi_sites
    if self.config.multi_sites?
      domain_name = self.config.multi_sites.domain
      raise '[Error] Locomotive needs a domain name when used as a multi sites platform' if domain_name.blank?
      self.config.domain = domain_name
    end
  end
  
  def self.configure_hosting
    #TODO Add Heroku Or Bushido support
  end
  
  def self.define_subdomain_and_domains_options
    if self.config.multi_sites?
      self.config.manage_subdomain = self.config.manage_domains = true
    else
      # Note: (Did) modify the code below if Journalist handles a new hosting solution (not a perfect solution though)
      # TODO REfacoring this...
      self.config.manage_domains = false
      self.config.manage_subdomain = false
    end
  end
  
  def self.log(*args)
    level   = args.size == 1 ? 'info' : args.first
    message = args.size == 1 ? args.first : args.last
    
    ::Journalist::Logger.send(level.to_sym, message)
  end
  
  # rack_cache: needed by default
  def self.rack_cache?
    self.config.rack_cache != false
  end
  
  protected
  
  def self.app_middleware
    Rails.application.middleware
  end
  
end

require "journalist/engine"