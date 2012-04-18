module Journalist
  module ProductionResource
    extend ActiveSupport::Concern
    included do
      include Journalist::Routing::SiteDispatcher
      include Journalist::Routing::BaseController

      load_and_authorize_resource

    end


  end
end
