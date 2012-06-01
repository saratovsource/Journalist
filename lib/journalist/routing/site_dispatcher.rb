module Journalist
  module Routing
    module SiteDispatcher
      extend ActiveSupport::Concern

      included do
        if self.respond_to?(:before_filter)
          before_filter :fetch_site
          #before_filter :require_site
          helper_method :current_site
          before_filter :set_locale
        end
      end

      module ClassMethods

      end

      module InstanceMethods
        protected

        def set_locale
          I18n.locale = current_account.locale rescue Journalist.config.default_locale
        end

        def create_guest_account_if_needed
          current_account ||= Account.new
        end

        def fetch_site
          Journalist.log "[fetch site] host = #{request.host} / #{request.env['HTTP_HOST']}"

          if Journalist.config.multi_sites?
            @current_site ||= Site.match_domain(request.host).first
          else
            @current_site ||= Site.first
          end
        end

        def current_site
          @current_site || fetch_site
        end

        def require_site
          return true if current_site

          redirect_to godmode_installation_url and return false if Account.count == 0 || Site.count == 0

          render_no_site_error and return false
        end

        def render_no_site_error
          render :template => '/errors/no_site', :layout => false, :status => :not_found
        end

        def validate_site_membership
          return true if current_site.present? && current_site.accounts.include?(current_account)

          sign_out(current_account)
          flash[:alert] = I18n.t(:no_membership, :scope => [:devise, :failure, :user])
          redirect_to new_account_session_url and return false
          #redirect_to new_session_url and return false
        end

      end
    end
  end
end
