class RenderingController < ApplicationController
  include Journalist::Routing::SiteDispatcher
  before_filter :retrive_route_object
  layout "journalist"
  
  def show
  end
  
  protected
  
  def retrive_route_object
    @routerable = current_site.find_object_by_path("/#{params[:path]}") if params[:path]
  end
end