module Journalist
  module Routing
    module BaseController
      extend ActiveSupport::Concern

      included do
        before_filter :require_site
        before_filter :validate_site_membership
        before_filter :delete_id_for_spine, :only =>[:new, :create]
        before_filter :set_locale
        before_filter :set_current_thread_variables

        respond_to :html
      end

      protected

      def delete_id_for_spine
        params.delete(:id)
        cl_name = resource_class.name.underscore.underscore
        params[cl_name].delete(:id)
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

      def begin_of_association_chain
        current_site
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


      module ClassMethods
      end

    end
  end
end
