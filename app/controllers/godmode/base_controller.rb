module Godmode
  class BaseController < ::InheritedResources::Base
    include Journalist::Routing::SiteDispatcher
    include Journalist::Routing::BaseController

    before_filter :validate_site_membership
    before_filter :require_admin
    before_filter :set_sidebar_menu

    load_and_authorize_resource

    layout "godmode"

    helper_method :sections, :current_site_url, :site_url, :page_url, :current_ability

    # https://rails.lighthouseapp.com/projects/8994/tickets/1905-apphelpers-within-plugin-not-being-mixed-in
    Dir[File.dirname(__FILE__) + "/../../helpers/godmode/*_helper.rb"].each do |file|
      helper "godmode/#{File.basename(file, '.rb').gsub(/_helper$/, '')}"
    end

    self.responder = Journalist::GodmodeResponder # custom responder
    defaults :route_prefix => 'godmode'


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

    def require_admin
      authenticate_account!
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

    def is_redactor?
      session[:account_type] == "editor"
    end

    def states_from_params(state)
      states = []
      if %w(drafted rewrited).include?(state)
        states << :drafted << :rewrited
      else
        states << state
      end
      states
    end

  end
end
