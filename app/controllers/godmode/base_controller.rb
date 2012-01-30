module Godmode
  class BaseController < InheritedResources::Base
    include Journalist::Routing::SiteDispatcher
    
    layout "godmode"
    
    before_filter :require_admin
    before_filter :require_site
    before_filter :validate_site_membership
    load_and_authorize_resource
    before_filter :set_locale
    before_filter :set_current_thread_variables
    before_filter :set_sidebar_menu
    helper_method :sections, :current_site_url, :site_url, :page_url, :current_ability
        
    # https://rails.lighthouseapp.com/projects/8994/tickets/1905-apphelpers-within-plugin-not-being-mixed-in
    Dir[File.dirname(__FILE__) + "/../../helpers/**/*_helper.rb"].each do |file|
      helper "godmode/#{File.basename(file, '.rb').gsub(/_helper$/, '')}"
    end
    
    self.responder = Journalist::GodmodeResponder # custom responder
    defaults :route_prefix => 'godmode'
    
    respond_to :html
    
    rescue_from CanCan::AccessDenied do |exception|
      ::Journalist.log "[CanCan::AccessDenied] #{exception.inspect}"

      if request.xhr?
        render :json => { :error => exception.message }
      else
        flash[:alert] = exception.message

        redirect_to root_url#admin_pages_url
      end
    end
    
    protected
    
    def set_sidebar_menu
      @sidebar_menu = true
    end
    
    def set_current_thread_variables
      Thread.current[:account] = current_account
      Thread.current[:site]  = current_site
      
      #set account_type
      session[:account_type] ||= "author"
    end
    
    def current_ability
      @current_ability ||= Ability.new(current_account, current_site)
    end
    
    def require_admin
      authenticate_account!
    end
    
    def begin_of_association_chain
      current_site
    end
    
    def self.sections(main, sub = nil)
      before_filter do |c|
        sub = sub.call(c) if sub.respond_to?(:call)
        sections = { :main => main, :sub => sub }
        c.instance_variable_set(:@godmode_sections, sections)
      end
    end

    def sections(key = nil)
      if !key.nil? && key.to_sym == :sub
        @godmode_sections[:sub] || self.controller_name.dasherize
      elsif !@godmode_sections.nil?
        @godmode_sections[:main]
      else
        ""
      end
    end
    
    def set_locale
      I18n.locale = current_account.locale rescue Journalist.config.default_locale
    end
    
    def current_site_url
      request.protocol + request.host_with_port
    end
    
    def site_url(site, options = {})
      options = { :fullpath => true, :protocol => true }.merge(options)

      url = "#{site.subdomain}.#{Journalist.config.domain}"
      url += ":#{request.port}" if request.port != 80

      url = File.join(url, request.fullpath) if options[:fullpath]
      url = "http://#{url}" if options[:protocol]
      url
    end
    
  end
end