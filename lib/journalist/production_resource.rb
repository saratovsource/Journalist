module Journalist
  module ProductionResource
    extend ActiveSupport::Concern
    included do
      include Journalist::Routing::SiteDispatcher

      before_filter :require_site
      load_and_authorize_resource
      before_filter :set_locale
      before_filter :set_current_thread_variables
    end
    
    
  end
end