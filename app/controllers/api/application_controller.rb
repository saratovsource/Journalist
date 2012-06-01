class Api::ApplicationController < ::InheritedResources::Base
  include Journalist::Routing::SiteDispatcher
  include Journalist::Routing::BaseController

  respond_to :json, :xml

  defaults :route_prefix => 'api'

  layout false

  protected

  def begin_of_association_chain
    current_site
  end
end
